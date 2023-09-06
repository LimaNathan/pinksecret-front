import 'package:asp/asp.dart';
import 'package:pinksecret_front/src/features/auth/interactor/dto/user_dto.dart';
import 'package:pinksecret_front/src/features/auth/interactor/states/auth_state.dart';

final authState = Atom<AuthState>(
  InitialAuth(),
  key: 'authState'
);

final checkAuthAction = Atom.action(key: 'checkAuthAction');
final loginAction = Atom<UserDTO>(
  UserDTO(),
  key: 'loginAction',
);

final loggoutAction = Atom.action(key: 'loggoutAction');
