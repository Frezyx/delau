import 'package:delau/models/user.dart';
import 'dart:convert';

import 'package:delau/config/serverConfig.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserHandler {
  static final handler = "user/";
  static final create = handler + "create";
  static final auth = handler + "auth";
  String _getEditionHandler(user) {
    return handler + "private/edit/${user.id}";
  }

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

  Future<Response> authUser(User user) async {
    Response response;
    final msg = jsonEncode({
      "email": user.email,
      "password": user.password,
    });
    try {
      response = await http.post(Server.path + auth,
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: msg);
      var result = response.statusCode == 200;

      if (!result) {
        response = null;
      }
    } catch (error) {
      response = null;
    }
    return response;
  }

  Future<bool> editUser(User user) async {
    bool result = false;
    final msg = jsonEncode({
      "email": user.email,
      "name": user.name,
      "surname": user.surname,
      "token_tg": user.tokenTG,
      "is_telegram_auth": user.isTelegramAuth
    });
    try {
      var response = await http.put(Server.path + _getEditionHandler(user),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            "Authorization": "token " + user.authToken,
          },
          body: msg);
      result = response.statusCode == 200;
    } catch (error) {
      result = false;
    }
    return result;
  }

  Future<Response> getUser(User user) async {
    bool result = false;
    Response response;
    try {
      response = await http.get(
        Server.path + "/user/private/getbyid/" + user.id.toString(),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "token ${user.authToken}",
        },
      );
      result = response.statusCode == 200;
    } catch (error) {
      result = false;
    }
    return response;
  }
}
