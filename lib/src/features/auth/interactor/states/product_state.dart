import 'package:pinksecret_front/src/features/home/models/product_model.dart';

sealed class ProductState {
  T when<T>({
    required T Function() init,
    T Function(LoadingProduct state)? loading,
    T Function(ProductsLoaded state)? loaded,
    T Function(ProductError state)? error,
  }) {
    return switch (this) {
      InitialProduct _ => init(),
      LoadingProduct s => loading?.call(s) ?? init(),
      ProductsLoaded s => loaded?.call(s) ?? init(),
      ProductError s => error?.call(s) ?? init(),
    };
  }
}

class InitialProduct extends ProductState {}

class LoadingProduct extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;
  ProductsLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
