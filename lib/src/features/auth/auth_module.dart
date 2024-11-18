import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/app_module.dart';
import 'package:pinksecret_front/src/features/auth/ui/pages/login_page.dart';
import 'package:pinksecret_front/src/shared/utils/constants/routes.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      Routes.login,
      child: (ctx) => LoginPage(),
    );
  }
}
