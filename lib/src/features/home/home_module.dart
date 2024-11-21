import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/app_module.dart';
import 'package:pinksecret_front/src/features/auth/data/services/category_service_impl.dart';
import 'package:pinksecret_front/src/features/auth/data/services/product_service_impl.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/category_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/product_service_interface.dart';
import 'package:pinksecret_front/src/features/home/ui/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    super.binds(i);

    i
      ..addSingleton<ProductServiceInterface>(ProductServiceImpl.new)
      ..addSingleton<CategoryServiceInterface>(CategoryServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (_) => HomePage());
  }
}
