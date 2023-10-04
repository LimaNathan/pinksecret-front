import 'dart:convert';

import 'package:pinksecret_front/src/core/service/api_service.dart';
import 'package:pinksecret_front/src/features/auth/interactor/dto/user_dto.dart';
import 'package:pinksecret_front/src/features/auth/interactor/entities/tokenization.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/auth_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';
import 'package:pinksecret_front/src/shared/utils/constants/endpoints.dart';
import 'package:pinksecret_front/src/shared/utils/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceIMPL implements AuthServiceInterface {
  final ApiService api;
  AuthServiceIMPL(this.api);
  @override
  Future<AuthState> checkAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(SharedPrefsKeys.token);

      if (token != null) {
        final response = await api.get(AuthEndpoints.checkToken);
        if (response.data['message'] != 'ok') return Unlogged();
        
        return Logged(Tokenization(accessToken: token));
      } else {
        return Unlogged();
      }
    } catch (e) {
      return Unlogged();
    }
  }

  @override
  Future<AuthState> loggout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return Unlogged();
  }

  @override
  Future<AuthState> login(UserDTO user) async {
    try {
      final authorization =
          base64Encode(utf8.encode('${user.email}:${user.password}'));
      api.addHeaders({'authorization': 'Basic $authorization'});
      final response = await api.get(AuthEndpoints.login);
      final prefs = await SharedPreferences.getInstance();
      if (response != null) {
        prefs.setString(SharedPrefsKeys.token, response.data['access_token']);
        prefs.setString(
            SharedPrefsKeys.refreshToken, response.data['refresh_token']);
      }
      return checkAuth();
    } catch (e) {
      return Unlogged();
    }
  }
}
