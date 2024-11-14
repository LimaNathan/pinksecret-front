import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/features/auth/interactor/dto/user_dto.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/auth_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';

final _service = Modular.get<AuthServiceInterface>();

final authState = atom<AuthState>(InitialAuth(), key: 'authState');
//actions
final performLoginAction = atomAction1<UserDTO>((set, user) async {
  set(authState, LoadingAuth());
  _service.login(user).then((result) => set(authState, result));
});

final verifyAuthAction = atomAction((set) {
  set(authState, LoadingAuth());
  _service.checkAuth().then((result) => set(authState, result));
});

final loggoutAction = atomAction((set) async {
  set(authState, LoadingAuth());
  await _service.loggout().then((result) => set(authState, result));
});
