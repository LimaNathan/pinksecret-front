sealed class HomeState {
  T when<T>(
      {required T Function() init,
      T Function(ShopState)? shop,
      T Function(StorageState)? storage,
      T Function(FinancialState)? financial}) {
    return switch (this) {
      InitalHomeState _ => init(),
      ShopState s => shop?.call(s) ?? init(),
      StorageState s => storage?.call(s) ?? init(),
      FinancialState s => financial?.call(s) ?? init(),
    };
  }
}

class InitalHomeState extends HomeState {}

class ShopState extends HomeState {}

class StorageState extends HomeState {}

class FinancialState extends HomeState {}
