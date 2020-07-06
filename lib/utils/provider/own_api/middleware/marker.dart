import 'dart:convert';

import 'package:delau/config/serverConfig.dart';
import 'package:delau/models/marker.dart';
import 'package:delau/models/user.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:http/http.dart' as http;

class MarkerHandler {
  static final handler = "marker/";
  static final create = handler + "create";

  Future<bool> createMarker(Marker marker) async {
    bool result = false;
    User user = await UserDB.udb.getUser();

    final msg = jsonEncode({
      "name": marker.icon,
      "icon": marker.name,
      "user_id": user.id,
    });
    try {
      var response = await http.post(Server.path + create,
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            "Authorization": "token ${user.authToken}",
          },
          body: msg);
      result = response.statusCode == 201;
    } catch (error) {
      result = false;
    }
    return result;
  }
}
