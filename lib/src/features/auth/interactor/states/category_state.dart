import 'package:pinksecret_front/src/features/home/models/category_model.dart';

sealed class CategoryState {
  T when<T>({
    required T Function() init,
    T Function(LoadingCategory state)? loading,
    T Function(CategoriesLoaded state)? loaded,
    T Function(CategoryError state)? error,
  }) {
    return switch (this) {
      InitialCategory _ => init(),
      LoadingCategory s => loading?.call(s) ?? init(),
      CategoriesLoaded s => loaded?.call(s) ?? init(),
      CategoryError s => error?.call(s) ?? init(),
    };
  }
}

class InitialCategory extends CategoryState {}

class LoadingCategory extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<CategoriaModel> categories;
  CategoriesLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}
