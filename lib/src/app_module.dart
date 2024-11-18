import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/core/service/api_service.dart';
import 'package:pinksecret_front/src/core/service/dio/dio_api_impl.dart';
import 'package:pinksecret_front/src/features/auth/auth_module.dart';
import 'package:pinksecret_front/src/features/auth/data/services/auth_service_spring_impl.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/auth_service_interface.dart';
import 'package:pinksecret_front/src/features/home/home_module.dart';
import 'package:pinksecret_front/src/features/splash/ui/pages/splash_page.dart';
import 'package:pinksecret_front/src/shared/utils/constants/routes.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    i.addSingleton<ApiService>(DioApiImpl.new);
    i.addSingleton<AuthServiceInterface>(AuthServiceSpringImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Routes.splash,
        child: (ctx) => SplashPage(),
      )
      ..module(
        Routes.auth,
        module: AuthModule(),
      )
      ..module(
        Routes.home,
        module: HomeModule(),
      );
  }
}
