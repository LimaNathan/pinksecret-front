import 'package:asp/asp.dart';
import 'package:pinksecret_front/src/features/home/iteractor/states/home_states.dart';

final homeState = atom<HomeState>(ShopState(), key: 'homeState');

final toShopAction = atomAction(
  (set) => set(
    homeState,
    ShopState(),
  ),
  key: 'toShopAction',
);
final toStorageAction = atomAction(
  (set) => set(
    homeState,
    StorageState(),
  ),
  key: 'toStorageAction',
);
final toDashboard = atomAction(
  (set) => set(
    homeState,
    StorageState(),
  ),
  key: 'toDashboard',
);

