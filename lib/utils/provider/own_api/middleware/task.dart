import 'dart:convert';

import 'package:delau/config/serverConfig.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/convert/epochFromDate.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TaskHandler {
  static final handler = "task/";
  static final create = handler + "create";
  static final getAll = handler + "get/all";

  Future<bool> createTask(Task task) async {
    bool result = false;
    final msg = jsonEncode({
      "date": epochFromDate(task.date),
      "time": epochFromDate(task.time),
      "name": task.name,
      "description": task.description,
      "marker_id": 1,
      "marker_name": task.icon,
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
      print(response.body);
    } catch (error) {
      print(error);
      result = false;
    }
    return result;
  }

  Future<Response> getTask() async {
    Response response;
    try {
      response = await http.get(
        Server.path + getAll + "/4",
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      );
    } catch (error) {}
    return response;
  }
}
