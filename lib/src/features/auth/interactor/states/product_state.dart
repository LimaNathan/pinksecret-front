import 'package:pinksecret_front/src/features/home/models/product_model.dart';

sealed class ProductState {
  T when<T>({
    required T Function() init,
    T Function(LoadingProduct state)? loading,
    T Function(ProductsLoaded state)? loaded,
    T Function(ProductError state)? error,
    T Function(OneProductLoaded state)? oneProductLoaded,
    T Function()? created,
  }) {
    return switch (this) {
      InitialProduct _ => init(),
      ProductCreated _ => created?.call() ?? init(),
      LoadingProduct s => loading?.call(s) ?? init(),
      ProductsLoaded s => loaded?.call(s) ?? init(),
      ProductError s => error?.call(s) ?? init(),
      OneProductLoaded s => oneProductLoaded?.call(s) ?? init(),
    };
  }
}

class InitialProduct extends ProductState {}

class LoadingProduct extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;
  final int? page;
  final int? totalPages;
  final int? totalProducts;
  ProductsLoaded(
    this.products, {
    this.page,
    this.totalPages,
    this.totalProducts,
  });
}

class OneProductLoaded extends ProductState {
  final ProductModel product;
  OneProductLoaded({
    required this.product,
  });
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductCreated extends ProductState {}
