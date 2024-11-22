import 'package:pinksecret_front/src/features/auth/interactor/states/product_state.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_product.dart';

abstract class ProductServiceInterface {
  Future<ProductState> fetchProductById(int id);
  Future<ProductState> updateProduct(CreateProduct updateProduct, int id);
  Future<ProductState> deleteProduct(int id);
  Future<ProductState> fetchProducts();
  Future<ProductState> createProduct(CreateProduct newProduct);
  Future<ProductState> fetchPaginated(({int page, int size}) pageable);
}
