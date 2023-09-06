import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/core/service/api_service.dart';
import 'package:pinksecret_front/src/core/service/uno/api_service_impl.dart';
import 'package:pinksecret_front/src/features/auth/data/services/auth_service_impl.dart';
import 'package:pinksecret_front/src/features/auth/interactor/reducers/auth_reducer.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/auth_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/ui/pages/login_page.dart';
import 'package:pinksecret_front/src/shared/utils/constants/routes.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i
      ..add<ApiService>(UnoImpl.new)
      ..add<AuthServiceInterface>(AuthServiceIMPL.new)
      ..addSingleton(AuthReducer.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Routes.login,
      child: (ctx) => LoginPage(),
    );
  }
}
