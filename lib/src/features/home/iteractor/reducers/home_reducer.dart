import 'package:asp/asp.dart';
import 'package:pinksecret_front/src/features/home/iteractor/atoms/home_atoms.dart';
import 'package:pinksecret_front/src/features/home/iteractor/states/home_states.dart';

class HomeReducer extends Reducer {
  HomeReducer() {
    on(() => [toShopAction], _toShopAction);
    on(() => [toStorageAction], _toStorageAction);
    on(() => [toFinancialAction], _toFinancialAction);
  }

  void _toShopAction() {
    homeState.value = ShopState();
  }

  void _toStorageAction() {
    homeState.value = StorageState();
  }

  void _toFinancialAction() {
    homeState.value = FinancialState();
  }
}
