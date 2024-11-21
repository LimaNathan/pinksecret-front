import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pinksecret_front/src/features/auth/interactor/dto/user_dto.dart';
import 'package:pinksecret_front/src/features/auth/interactor/service/auth_service_interface.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';
import 'package:pinksecret_front/src/shared/utils/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authState = atom<AuthState>(InitialAuth(), key: 'authState');

final performLoginAction = atomAction1<UserDTO>((set, user) async {
  final service = Modular.get<AuthServiceInterface>();
  set(authState, LoadingAuth());
  service.login(user).then((result) => set(authState, result));
});

final verifyAuthAction = atomAction((set) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString(SharedPrefsKeys.token) == null) {
    set(authState, Unlogged());
    return;
  }
  final service = Modular.get<AuthServiceInterface>();
  service.checkAuth().then((result) => set(authState, result));
});

final loggoutAction = atomAction((set) async {
  final service = Modular.get<AuthServiceInterface>();
  set(authState, LoadingAuth());
  service.loggout().then((result) => set(authState, result));
});
