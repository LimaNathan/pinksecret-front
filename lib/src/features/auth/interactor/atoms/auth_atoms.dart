import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/features/auth/interactor/dto/user_dto.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/auth_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';

final authState = atom<AuthState>(InitialAuth(), key: 'authState');

final performLoginAction = atomAction1<UserDTO>((set, user) async {
  final service = Modular.get<AuthServiceInterface>();
  set(authState, LoadingAuth());
  service.login(user).then((result) => set(authState, result));
});

final verifyAuthAction = atomAction((set) {
  final service = Modular.get<AuthServiceInterface>();
  // set(authState, LoadingAuth());
  service.checkAuth().then((result) => set(authState, result));
});

final loggoutAction = atomAction((set) async {
  final service = Modular.get<AuthServiceInterface>();
  set(authState, LoadingAuth());
  service.loggout().then((result) => set(authState, result));
});
