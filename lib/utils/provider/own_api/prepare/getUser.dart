import 'package:delau/models/user.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'dart:convert' as convert;

Future<User> getEnteredUser() async {
  User userLocal = await UserDB.udb.getUser();
  var response = await API.userHandler.getUser(userLocal);
  var jsonResponse = convert.jsonDecode(response.body);
  User user = User.fromMap(jsonResponse);
  user.authToken = userLocal.authToken;

  return user;
}
