import 'package:delau/models/user.dart';
import 'dart:convert';

import 'package:delau/config/serverConfig.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserHandler {
  static final handler = "user/";
  static final create = handler + "create";
  static final auth = handler + "auth";

  Future<bool> createUser(User user) async {
    bool result = false;
    final msg = jsonEncode({
      "email": user.email,
      "name": user.name,
      "surname": user.surname,
      "password": user.password,
    });
    try {
      var response = await http.post(Server.path + create,
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: msg);
      result = response.statusCode == 201;
    } catch (error) {
      result = false;
    }
    return result;
  }

  Future<bool> authUser(User user) async {
    bool result = false;
    final msg = jsonEncode({
      "email": user.email,
      "password": user.password,
    });
    try {
      var response = await http.post(Server.path + auth,
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: msg);
      result = response.statusCode == 200;
    } catch (error) {
      result = false;
    }
    return result;
  }
}
