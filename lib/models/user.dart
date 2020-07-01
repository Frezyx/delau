import 'dart:convert';

class User {
  int id;
  String email;
  String password;
  String name;
  String surname;
  String tokenTG;
  String photoUrl;
  bool isTelegramAuth;

  User({
    this.id,
    this.email,
    this.password,
    this.name,
    this.surname,
    this.tokenTG,
    this.photoUrl,
    this.isTelegramAuth,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
      'tokenTG': tokenTG,
      'photoUrl': photoUrl,
      'isTelegramAuth': isTelegramAuth,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
      surname: map['surname'],
      tokenTG: map['token_tg'],
      photoUrl: map['photoUrl'],
      isTelegramAuth: map['is_telegram_auth'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));
}
