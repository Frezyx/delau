import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart';

Future<List<Task>> getUserPartiesList(int userID) async {
  Response res = await API.taskHandler.getTask();

  var data = convert.jsonDecode(res.body);
  var taskList = <Task>[];
  for (var task in data) {
    Task taskFromServer = Task.fromMap(task);
    taskList.add(taskFromServer);
  }
  return taskList;
}
