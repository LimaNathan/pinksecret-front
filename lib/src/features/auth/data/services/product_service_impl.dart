import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pinksecret_front/src/core/service/api_service.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/product_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/product_state.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_product.dart';
import 'package:pinksecret_front/src/features/home/models/product_model.dart';
import 'package:pinksecret_front/src/shared/utils/constants/endpoints.dart';

class ProductServiceImpl implements ProductServiceInterface {
  static const String productLogger = 'SERVIÇO_PRODUTO';
  ApiService api;
  ProductServiceImpl(this.api);

  @override
  Future<ProductState> fetchProducts() async {
    try {
      log('Iniciando a busca por produtos...', name: productLogger);
      final response = await api.get(ProductEndpoints.fetchAll);
      if (response != null) {
        log('Produtos encontrados: ${response.data.length} produtos.',
            name: productLogger);
        return ProductsLoaded((response.data as List)
            .map((product) => ProductModel.fromJson(product))
            .toList());
      }
      log('Falha ao buscar produtos: resposta nula recebida da API.',
          name: productLogger);
      return ProductError('Falha ao buscar produtos');
    } on DioException catch (e) {
      log('Erro ao buscar produtos: ${e.error}', name: productLogger);

      return ProductError('Erro ao buscar produtos: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } catch (e) {
      log('Erro ao buscar produtos: $e', name: productLogger);
      return ProductError('Erro ao buscar produtos');
    }
  }

  @override
  Future<ProductState> fetchProductById(int id) async {
    try {
      log('Buscando produto com ID: $id', name: productLogger);
      final response = await api.get('${ProductEndpoints.fetchById}/$id');
      if (response != null) {
        log('Produto com ID $id encontrado: ${response.data}',
            name: productLogger);
        return ProductsLoaded([ProductModel.fromJson(response.data)]);
      }
      log('Falha ao buscar produto com ID $id: resposta nula.',
          name: productLogger);
      return ProductError('Falha ao buscar produto');
    } on DioException catch (e) {
      log('Erro ao buscar produto: ${e.error}', name: productLogger);

      return ProductError('Erro ao buscar produto por id {$id}: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } catch (e) {
      log('Erro ao buscar produto com ID $id: $e', name: productLogger);
      return ProductError('Erro ao buscar produto');
    }
  }

  @override
  Future<ProductState> createProduct(CreateProduct newProduct) async {
    try {
      log('Criando produto: ${newProduct.nome}', name: productLogger);
      final response =
          await api.post(ProductEndpoints.create, body: newProduct.toJson());
      if (response != null) {
        log('Produto criado com sucesso: ${response.data}',
            name: productLogger);
        return ProductCreated();
      }
      log('Falha ao criar produto: resposta nula recebida da API.',
          name: productLogger);
      return ProductError('Falha ao criar produto');
    } on DioException catch (e) {
      log('Erro ao criar produto: ${e.error}', name: productLogger);

      return ProductError('Erro ao criar produto: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    }
  }

  @override
  Future<ProductState> updateProduct(
      CreateProduct updateProduct, int id) async {
    try {
      log('Atualizando produto com ID: $id', name: productLogger);
      final response = await api.update('${ProductEndpoints.update}/$id',
          body: updateProduct.toJson());
      if (response != null) {
        log('Produto com ID $id atualizado com sucesso: ${response.data}',
            name: productLogger);
        return ProductsLoaded((response.data as List)
            .map((json) => ProductModel.fromJson(json))
            .toList());
      }
      log('Falha ao atualizar produto com ID $id: resposta nula recebida da API.',
          name: productLogger);
      return ProductError('Falha ao atualizar produto');
    } on DioException catch (e) {
      log('Erro ao atualizar produto: ${e.error}', name: productLogger);

      return ProductError('Erro ao atualizar produto: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } catch (e) {
      log('Erro ao atualizar produto com ID $id: $e', name: productLogger);
      return ProductError('Erro ao atualizar produto');
    }
  }

  @override
  Future<ProductState> deleteProduct(int id) async {
    try {
      log('Iniciando exclusão do produto com ID: $id', name: productLogger);
      final response = await api.delete(ProductEndpoints.delete, id: id);
      if (response != null && response.statusCode == 200) {
        log('Produto com ID $id excluído com sucesso.', name: productLogger);
        return InitialProduct();
      }
      log('Falha ao excluir produto com ID $id: resposta da API não foi bem-sucedida.',
          name: productLogger);
      return ProductError('Falha ao excluir produto');
    } on DioException catch (e) {
      log('Erro ao criar produto: ${e.error}', name: productLogger);

      return ProductError('Erro ao criar produto: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } catch (e) {
      log('Erro ao excluir produto com ID $id: $e', name: productLogger);
      return ProductError('Erro ao excluir produto');
    }
  }

  @override
  @override
  Future<ProductState> fetchPaginated(({int page, int size}) pageable) async {
    final page = pageable.page;
    final size = pageable.size;
    try {
      log('Iniciando a busca por produtos paginados (page: $page, size: $size)...',
          name: productLogger);

      final response = await api.get(
        ProductEndpoints.fetchPage,
        queryParams: {
          'page': page,
          'size': size,
        },
      );

      if (response != null && response.data != null) {
        final data = response.data;

        if (data['content'] != null) {
          log('Produtos encontrados: ${data['content'].length} produtos na página $page.',
              name: productLogger);

          return ProductsLoaded(
              (data['content'] as List)
                  .map((json) => ProductModel.fromJson(Map.from(json)))
                  .toList(),
              page: data['pageable']['pageNumber'],
              totalPages: data['totalPages'],
              totalProducts: data['totalElements']);
        }

        log('Falha ao buscar produtos: formato de resposta inesperado.',
            name: productLogger);
        return ProductError('Formato de resposta inesperado');
      }

      log('Falha ao buscar produtos: resposta nula recebida da API.',
          name: productLogger);
      return ProductError('Falha ao buscar produtos');
    } on DioException catch (e) {
      log('Erro ao criar produto: ${e.error}', name: productLogger);

      return ProductError('Erro ao criar produto: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } catch (e) {
      log('Erro ao buscar produtos: $e', name: productLogger);
      return ProductError('Erro ao buscar produtos');
    }
  }
}
