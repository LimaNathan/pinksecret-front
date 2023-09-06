import 'package:pinksecret_front/src/features/auth/interactor/dto/user_dto.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';

abstract class AuthServiceInterface {
  Future<AuthState> login(UserDTO user);
  Future<AuthState> loggout();
  Future<AuthState> checkAuth();
}
