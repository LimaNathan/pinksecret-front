class AuthEndpoints {
  static const String _baseURL = String.fromEnvironment('base_url');

  AuthEndpoints._();
  static const String login = '$_baseURL/auth/login';
  static const String checkToken = '$_baseURL/auth/check-token';
  static const String refreshToken = '$_baseURL/auth/refresh-token';
}

class UserEndpoints {
  static const String _baseURL = String.fromEnvironment('base_url');

  UserEndpoints._();
  static const String all = '$_baseURL/user/all';
  static const String create = '$_baseURL/user/create';

  ///Can use to every user action with id, just need to change the HTTP verb
  String userByID(int id) => '$_baseURL/user/$id';
}

class TypeEndpoints {
  static const String _baseURL = String.fromEnvironment('base_url');

  TypeEndpoints._();
  static const String all = '$_baseURL/type/all';
  static const String create = '$_baseURL/type/create';

  ///Can use to every type action with id, just need to change the HTTP verb
  String typeByID(int id) => '$_baseURL/type/$id';
}

class ProductEndpoints {
  static const String _baseURL = String.fromEnvironment('base_url');

  ProductEndpoints._();
  static const String all = '$_baseURL/product/all';
  static const String create = '$_baseURL/product/create';

  ///Can use to every product action with id, just need to change the HTTP verb
  String productByID(int id) => '$_baseURL/product/$id';
}
