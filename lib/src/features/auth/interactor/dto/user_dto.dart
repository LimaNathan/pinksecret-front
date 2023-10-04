import 'dart:convert';

class UserDTO {
  int? id;
  String? name;
  String? email;
  String? password;
  String? role;

  UserDTO({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
  });

  Map<dynamic, dynamic> toMap() => <dynamic, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      };

  factory UserDTO.fromMap(Map<dynamic, dynamic> map) => UserDTO(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
        role: map['role'],
      );

  String toJson() => json.encode(toMap());

  factory UserDTO.fromJson(String source) =>
      UserDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
