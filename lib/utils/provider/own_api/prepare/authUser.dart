import 'package:delau/models/user.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'dart:convert' as convert;

Future<bool> loginUser(User user) async {
  bool result = false;

  var res = await API.userHandler.authUser(user);
  if (res.statusCode == 200 && res != null) {
    var jsonResponse = convert.jsonDecode(res.body);
    user.id = jsonResponse["id"];
    user.isAuth = jsonResponse["is_auth"];
    user.authToken = jsonResponse["token"];
    result = await localAuth(user);
  } else {
    result = false;
  }

  return result;
}

Future<bool> localAuth(user) async {
  return await UserDB.udb.authUser(user);
}

Future<bool> regUser(User user) async {
  bool result = false;
  result = await API.userHandler.createUser(user);
  if (result) {
    result = await loginUser(user);
  }
  return result;
}
