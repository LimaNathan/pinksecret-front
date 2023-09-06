import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/features/auth/auth_module.dart';
import 'package:pinksecret_front/src/features/splash/ui/pages/splash_page.dart';
import 'package:pinksecret_front/src/shared/utils/constants/routes.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [AuthModule()];
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
      );
  }
}
