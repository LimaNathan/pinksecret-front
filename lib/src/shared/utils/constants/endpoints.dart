class AuthEndpoints {
  AuthEndpoints._();
  static const String login = '/auth/login';
  static const String checkToken = '/auth/check-token';
  static const String refreshToken = '/auth/refresh-token';
}

class UserEndpoints {
  UserEndpoints._();
  static const String all = '/user/all';
  static const String create = '/user/create';

  ///Can use to every user action with id, just need to change the HTTP verb
  String userByID(int id) => '/user/$id';
}

class TypeEndpoints {
  TypeEndpoints._();
  static const String all = '/type/all';
  static const String create = '/type/create';

  ///Can use to every type action with id, just need to change the HTTP verb
  String typeByID(int id) => '/type/$id';
}

class ProductEndpoints {
  ProductEndpoints._();
  static const String all = '/product/all';
  static const String create = '/product/create';

  ///Can use to every product action with id, just need to change the HTTP verb
  String productByID(int id) => '/product/$id';
}
