import 'package:pinksecret_front/src/features/auth/interactor/states/category_state.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_category.dart';

abstract class CategoryServiceInterface {
  Future<CategoryState> fetchCategoryById(int id);
  Future<CategoryState> updateCategory(CreateCategory updateCategory, int id);
  Future<CategoryState> deleteCategory(int id);
  Future<CategoryState> fetchCategories();
  Future<CategoryState> createCategory(CreateCategory newCategory);
}
