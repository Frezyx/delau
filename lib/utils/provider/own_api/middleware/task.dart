import 'dart:convert';

import 'package:delau/config/serverConfig.dart';
import 'package:delau/models/task.dart';
import 'package:http/http.dart' as http;

class TaskHandler {
  static final handler = "task/";
  static final create = handler + "create";

  Future<bool> createTask(Task task) async {
    bool result = false;
    final msg = jsonEncode({
      "date_time": 1223432343,
      "name": "Поссать",
      "description": "Нужно",
      "marker_id": 45,
      "marker_name": "not",
      "user_id": 4
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
}
