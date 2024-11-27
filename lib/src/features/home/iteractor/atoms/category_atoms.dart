import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/category_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/category_state.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_category.dart';

final categoryState =
    atom<CategoryState>(InitialCategory(), key: 'categoryState');

final fetchCategoriesAction = atomAction((set) async {
  final service = Modular.get<CategoryServiceInterface>();
  set(categoryState, LoadingCategory());

  service.fetchCategories().then((result) => set(categoryState, result));
});

final fetchCategoryByIdAction = atomAction1<int>((set, id) async {
  final service = Modular.get<CategoryServiceInterface>();
  set(categoryState, LoadingCategory());
  service.fetchCategoryById(id).then((result) => set(categoryState, result));
});

final createCategoryAction = atomAction1<CreateCategory>((set, category) async {
  final service = Modular.get<CategoryServiceInterface>();
  set(categoryState, LoadingCategory());
  service.createCategory(category).then((result) => set(categoryState, result));
});

final updateCategoryAction =
    atomAction2<CreateCategory, int>((set, category, id) async {
  final service = Modular.get<CategoryServiceInterface>();
  set(categoryState, LoadingCategory());
  service
      .updateCategory(category, id)
      .then((result) => set(categoryState, result));
});

final deleteCategoryAction = atomAction1<int>((set, id) async {
  final service = Modular.get<CategoryServiceInterface>();
  set(categoryState, LoadingCategory());
  service.deleteCategory(id).then((result) => set(categoryState, result));
});
