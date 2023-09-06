import 'package:pinksecret_front/src/features/auth/interactor/entities/tokenization.dart';

sealed class AuthState {
  T when<T>({
    required T Function() init,
    T Function(LoadingAuth state)? loading,
    T Function(Logged state)? logged,
    T Function(Unlogged state)? unlogged,
  }) {
    return switch (this) {
      InitialAuth _ => init(),
      LoadingAuth s => loading?.call(s) ?? init(),
      Logged s => logged?.call(s) ?? init(),
      Unlogged s => unlogged?.call(s) ?? init(),
    };
  }
}

class InitialAuth extends AuthState {}

class LoadingAuth extends AuthState {}

class Logged extends AuthState {
  final Tokenization tokenization;
  Logged(this.tokenization);
}

class Unlogged extends AuthState {}
