import 'package:pinksecret_front/src/core/service/api_service.dart';
import 'package:pinksecret_front/src/features/auth/interactor/dto/user_dto.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/auth_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';
import 'package:pinksecret_front/src/shared/utils/constants/endpoints.dart';
import 'package:pinksecret_front/src/shared/utils/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceSpringImpl implements AuthServiceInterface {
  ApiService api;
  AuthServiceSpringImpl(this.api);
  @override
  Future<AuthState> checkAuth() async {
    return Unlogged();
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
      final response = await api.post(AuthEndpoints.login, body: {
        'email': user.email,
        'senha': user.password,
      });
      final prefs = await SharedPreferences.getInstance();
      if (response != null) {
        prefs.setString(SharedPrefsKeys.token, response.data['token']);
      }
      return checkAuth();
    } catch (e) {
      return Unlogged();
    }
  }
}
