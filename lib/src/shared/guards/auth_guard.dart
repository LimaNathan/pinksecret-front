import 'dart:async';
import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/shared/utils/constants/routes.dart';
import 'package:pinksecret_front/src/shared/utils/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '${Routes.auth}${Routes.login}');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final prefs = await SharedPreferences.getInstance();
    final canActivate = prefs.containsKey(SharedPrefsKeys.token);

    log(
      'Usuário ${canActivate ? 'já' : 'não'} está autenticado',
      name: 'AUTH GUARD',
    );

    return canActivate;
  }
}
