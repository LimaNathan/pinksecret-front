import 'package:asp/asp.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/home_atoms.dart';
import 'package:pinksecret_front/src/features/home/iteractor/states/home_states.dart';

class HomeReducer extends Reducer {
  HomeReducer() {
    on(() => [toShopAction], _toShopAction);
    on(() => [toStorageAction], _toStorageAction);
    on(() => [toDashboard], _toDashboard);
  }

  void _toShopAction() {
    homeState.setValue(ShopState());
  }

  void _toDashboard() {
    homeState.setValue(DashboardState());
  }

  void _toStorageAction() {
    homeState.setValue(StorageState());
  }
}
