import 'dart:developer';

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
        return ProductsLoaded([ProductModel.fromJson(response.data)]);
      }
      log('Falha ao criar produto: resposta nula recebida da API.',
          name: productLogger);
      return ProductError('Falha ao criar produto');
    } catch (e) {
      log('Erro ao criar produto: $e', name: productLogger);
      return ProductError('Erro ao criar produto');
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
    } catch (e) {
      log('Erro ao excluir produto com ID $id: $e', name: productLogger);
      return ProductError('Erro ao excluir produto');
    }
  }
}
