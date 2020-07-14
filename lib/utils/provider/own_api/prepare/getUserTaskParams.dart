import 'package:delau/models/task.dart';
import 'package:delau/models/templates/UserParams.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'dart:convert' as convert;

Future<UserParams> getUserParams() async {
  var tasksCount = 0;
  var todayTasksCount = 0;
  var doneTaskCount = 0;

  var res = await API.taskHandler.getTask();
  var data = convert.jsonDecode(res.body);
  var date = DateTime.now();
  var nowday = DateTime(date.year, date.month, date.day);

  for (var task in data) {
    Task taskFromServer = Task.fromMap(task);
    var dateSrv = taskFromServer.date;
    var day = DateTime(dateSrv.year, dateSrv.month, dateSrv.day);
    tasksCount++;
    if (day.millisecondsSinceEpoch == nowday.millisecondsSinceEpoch) {
      todayTasksCount++;
    }

    if (taskFromServer.isChecked) {
      doneTaskCount++;
    }
  }
  return new UserParams(
      countAll: tasksCount.toString(),
      countDay: todayTasksCount.toString(),
      countDone: doneTaskCount.toString());
}
