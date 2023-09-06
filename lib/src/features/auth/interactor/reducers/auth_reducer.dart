import 'package:asp/asp.dart';
import 'package:pinksecret_front/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/auth_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';

class AuthReducer extends Reducer {
  final AuthServiceInterface service;

  AuthReducer(this.service) {
    on(() => [checkAuthAction], _checkAuthAction);
    on(() => [loggoutAction], _loggoutAction);
    on(() => [loginAction], _loginAction);
  }

  void _checkAuthAction() {
    authState.value = LoadingAuth();
    service.checkAuth().then(authState.setValue);
  }

  void _loggoutAction() {
    authState.value = LoadingAuth();
    service.loggout().then(authState.setValue);
  }

  void _loginAction() {
    authState.value = LoadingAuth();
    service.login(loginAction.value).then(authState.setValue);
  }
}
