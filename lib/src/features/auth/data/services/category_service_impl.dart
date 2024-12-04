import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pinksecret_front/src/core/service/api_service.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/category_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/category_state.dart';
import 'package:pinksecret_front/src/features/home/models/category_model.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_category.dart';
import 'package:pinksecret_front/src/shared/utils/constants/endpoints.dart';

class CategoryServiceImpl implements CategoryServiceInterface {
  static const String categoryLogger = 'SERVIÇO_CATEGORIA';
  ApiService api;
  CategoryServiceImpl(this.api);

  @override
  Future<CategoryState> fetchCategories() async {
    try {
      log('Iniciando a busca por categorias...', name: categoryLogger);
      final response = await api.get(CategoryEndpoints.fetchAll);
      if (response != null) {
        log('Categorias encontradas: ${response.data.length} categorias.',
            name: categoryLogger);
        return CategoriesLoaded((response.data as List)
            .map((category) => CategoriaModel.fromJson(category))
            .toList());
      }
      log('Falha ao buscar categorias: resposta nula recebida da API.',
          name: categoryLogger);
      return CategoryError('Falha ao buscar categorias');
    } on DioException catch (e) {
      log(
        'Erro ao buscar categorias: ${e.error}',
        name: categoryLogger,
      );
      return CategoryError('Erro ao buscar categorias: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } on Exception catch (e) {
      log('Erro ao buscar categorias: $e', name: categoryLogger);
      return CategoryError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<CategoryState> fetchCategoryById(int id) async {
    try {
      log('Buscando categoria com ID: $id', name: categoryLogger);
      final response = await api.get('${CategoryEndpoints.fetchById}/$id');
      if (response != null) {
        log('Categoria com ID $id encontrada: ${response.data}',
            name: categoryLogger);
        return CategoriesLoaded([CategoriaModel.fromJson(response.data)]);
      }
      log('Falha ao buscar categoria com ID $id: resposta nula.',
          name: categoryLogger);
      return CategoryError('Falha ao buscar categoria');
    } on DioException catch (e) {
      log(
        'Erro ao buscar categoria por id {$id}: ${e.error}',
        name: categoryLogger,
      );
      return CategoryError('Erro ao buscar categoria por id: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } catch (e) {
      log('Erro ao buscar categoria com ID $id: $e', name: categoryLogger);
      return CategoryError('Erro ao buscar categoria');
    }
  }

  @override
  Future<CategoryState> createCategory(CreateCategory newCategory) async {
    try {
      log('Criando categoria: ${newCategory.nome}', name: categoryLogger);
      final response =
          await api.post(CategoryEndpoints.create, body: newCategory.toJson());
      if (response != null) {
        log('Categoria criada com sucesso: ${response.data}',
            name: categoryLogger);
        return CategoriesLoaded([CategoriaModel.fromJson(response.data)]);
      }
      log('Falha ao criar categoria: resposta nula recebida da API.',
          name: categoryLogger);
      return CategoryError('Falha ao criar categoria');
    } on DioException catch (e) {
      log(
        'Erro ao criar categoria: ${e.error}',
        name: categoryLogger,
      );
      return CategoryError('Erro ao criar categoria:  '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } catch (e) {
      log('Erro ao criar categoria: $e', name: categoryLogger);
      return CategoryError('Erro ao criar categoria');
    }
  }

  @override
  Future<CategoryState> updateCategory(
      CreateCategory updateCategory, int id) async {
    try {
      log('Atualizando categoria com ID: $id', name: categoryLogger);
      final response = await api.update('${CategoryEndpoints.update}/$id',
          body: updateCategory.toJson());
      if (response != null) {
        log('Categoria com ID $id atualizada com sucesso: ${response.data}',
            name: categoryLogger);

        return CategoriesLoaded(
          (response.data as List)
              .map((json) => CategoriaModel.fromJson(json))
              .toList(),
        );
      }
      log('Falha ao atualizar categoria com ID $id: resposta nula recebida da API.',
          name: categoryLogger);
      return CategoryError('Falha ao atualizar categoria');
    } on DioException catch (e) {
      log(
        'Erro ao atualizar categoria por id {$id}: ${e.error}',
        name: categoryLogger,
      );
      return CategoryError('Erro ao atualizar categoria por id: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } catch (e) {
      log('Erro ao atualizar categoria com ID $id: $e', name: categoryLogger);
      return CategoryError('Erro ao atualizar categoria');
    }
  }

  @override
  Future<CategoryState> deleteCategory(int id) async {
    try {
      log('Iniciando exclusão da categoria com ID: $id', name: categoryLogger);
      final response = await api.delete(
        CategoryEndpoints.delete,
        id: id,
      );
      if (response != null && response.statusCode == 200) {
        log('Categoria com ID $id excluída com sucesso.', name: categoryLogger);
        return InitialCategory();
      }
      log('Falha ao excluir categoria com ID $id: resposta da API não foi bem-sucedida.',
          name: categoryLogger);
      return CategoryError('Falha ao excluir categoria');
    } on DioException catch (e) {
      log(
        'Erro ao deletar categoria por id {$id}: ${e.error}',

        name: categoryLogger,
      );
      return CategoryError('Erro ao deletar categoria por id: '
          '${e.error.toString().replaceAll('Exception: ', '')}');
    } catch (e) {
      log('Erro ao excluir categoria com ID $id: $e', name: categoryLogger);
      return CategoryError('Erro ao excluir categoria');
    }
  }
}
