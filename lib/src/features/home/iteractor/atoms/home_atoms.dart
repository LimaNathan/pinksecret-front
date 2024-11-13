import 'package:asp/asp.dart';
import 'package:pinksecret_front/src/features/home/iteractor/states/home_states.dart';

final homeState = Atom<HomeState>(ShopState(), key: 'homeState');

final toShopAction = Atom.action(key: 'toShopAction');
final toStorageAction = Atom.action(key: 'toStorageAction');
final toDashboard = Atom.action(key: 'toDashboard');
