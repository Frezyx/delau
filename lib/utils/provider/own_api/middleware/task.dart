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
      "date": task.date?.millisecondsSinceEpoch,
      "time": task.time?.millisecondsSinceEpoch,
      "name": task.name,
      "description": task.description,
      "marker_id": 1,
      "marker_name": task.icon,
      "user_id": 0
    });
    try {
      var response = await http.post(Server.path + create,
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: msg);
      result = response.statusCode == 201;
      print(response.body);
    } catch (error) {
      print(error);
      result = false;
    }
    return result;
  }
}
