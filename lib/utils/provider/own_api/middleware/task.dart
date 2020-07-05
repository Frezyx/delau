import 'dart:convert';

import 'package:delau/config/serverConfig.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/user.dart';
import 'package:delau/utils/convert/epochFromDate.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TaskHandler {
  static final handler = "task/";
  static final create = handler + "create";
  static final getAll = handler + "get/all";
  static final getAllByDate = handler + "get/bydate";
  getCheckHandler(int id) {
    return handler + id.toString() + "/check";
  }

  getAllMarkersHandler(int id) {
    return handler + "/get/markers/" + id.toString();
  }

  static final check = handler + "create";

  Future<bool> createTask(Task task) async {
    bool result = false;
    User user = await UserDB.udb.getUser();
    final msg = jsonEncode({
      "date": epochFromDate(task.date),
      "time": epochFromDate(task.time),
      "name": task.name,
      "description": task.description,
      "marker_icon": task.icon,
      "marker_name": task.markerName,
      "user_id": user.id,
      "rating": task.rating,
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
      result = false;
    }
    return result;
  }

  Future<Response> getTask() async {
    Response response;
    User user = await UserDB.udb.getUser();
    try {
      response = await http.get(
        Server.path + getAll + "/${user.id}",
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      );
    } catch (error) {}
    return response;
  }

  Future<Response> getTaskByDate(DateTime date) async {
    Response response;
    User user = await UserDB.udb.getUser();
    final msg = jsonEncode({
      "date": epochFromDate(date),
    });
    try {
      response = await http.post(
        Server.path + getAllByDate + "/${user.id}",
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: msg,
      );
    } catch (error) {}
    return response;
  }

  Future<Response> getAllMarkers() async {
    Response response;
    User user = await UserDB.udb.getUser();
    try {
      response = await http.get(
        Server.path + getAllMarkersHandler(user.id),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      );
    } catch (error) {}
    return response;
  }

  Future<bool> checkTask(int id) async {
    bool result = false;
    try {
      var response =
          await http.put(Server.path + getCheckHandler(id), headers: {
        "content-type": "application/json",
        "accept": "application/json",
      });
      result = response.statusCode == 200;
    } catch (error) {
      result = false;
    }
    return result;
  }
}
