import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/product_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/product_state.dart';
import 'package:pinksecret_front/src/features/home/models/create/create_product.dart';

final productState = atom<ProductState>(InitialProduct(), key: 'productState');

final fetchProductsAction = atomAction((set) async {
  final service = Modular.get<ProductServiceInterface>();
  set(productState, LoadingProduct());
  service.fetchProducts().then(
        (result) => set(productState, result),
      );
});
final fetchProductsPaginatedAction = atomAction1((
  set,
  ({int page, int size}) pageable,
) async {
  final service = Modular.get<ProductServiceInterface>();
  set(productState, LoadingProduct());
  service.fetchPaginated(pageable).then((result) => set(productState, result));
});

final fetchProductByIdAction = atomAction1<int>((set, id) async {
  final service = Modular.get<ProductServiceInterface>();
  set(productState, LoadingProduct());
  service.fetchProductById(id).then((result) => set(productState, result));
});

final createProductAction = atomAction1<CreateProduct>((set, product) async {
  final service = Modular.get<ProductServiceInterface>();
  set(productState, LoadingProduct());
  service.createProduct(product).then((result) => set(productState, result));
});

final updateProductAction =
    atomAction2<CreateProduct, int>((set, product, id) async {
  final service = Modular.get<ProductServiceInterface>();
  set(productState, LoadingProduct());
  service
      .updateProduct(product, id)
      .then((result) => set(productState, result));
});

final deleteProductAction = atomAction1<int>((set, id) async {
  final service = Modular.get<ProductServiceInterface>();
  set(productState, LoadingProduct());
  service.deleteProduct(id).then((result) => set(productState, result));
});
