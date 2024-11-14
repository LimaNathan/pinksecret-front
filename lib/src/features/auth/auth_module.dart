import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/core/service/api_interceptor.dart';
import 'package:pinksecret_front/src/core/service/dio/dio_api_inteceptor_impl.dart';
import 'package:pinksecret_front/src/features/auth/data/services/auth_service_spring_impl.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/auth_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/ui/pages/login_page.dart';
import 'package:pinksecret_front/src/shared/utils/constants/routes.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(Injector i) {
    final dioInstance = Dio();
    dioInstance.interceptors.addAll(
      [
        DioApiInteceptorImpl().interceptor,
        RetryInterceptor(
          dio: dioInstance,
          retries: 5,
          logPrint: (message) => log(message, name: 'RETRY'),
          retryDelays: [
            Duration(seconds: 2),
            Duration(seconds: 2),
            Duration(seconds: 2),
            Duration(seconds: 2),
            Duration(seconds: 2),
          ],
        ),
      ],
    );
    i
      ..addSingleton<ApiInterceptor>(DioApiInteceptorImpl.new)
      ..add<AuthServiceInterface>(AuthServiceSpringImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Routes.login,
      child: (ctx) => LoginPage(),
    );
  }
}
