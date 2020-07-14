import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'package:delau/utils/provider/own_api/prepare/getTasksList.dart';
import 'package:flutter/material.dart';

class ListItemBloc extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }

  bool _isEventsLoad = false;
  bool get isEventsLoad => _isEventsLoad;
  set isEventsLoad(bool val) {
    _isEventsLoad = val;
    notifyListeners();
  }

  Map<DateTime, List<Task>> _events = {};

  Map<DateTime, List<Task>> get events => _events;

  set events(Map<DateTime, List<Task>> val) {
    _events = val;
    notifyListeners();
  }

  getEventsByDate(DateTime date) {
    var dateInDay = DateTime(date.year, date.month, date.day);
    return _events[dateInDay];
  }

  loadEvents() async {
    if (!_isEventsLoad) {
      var taskList = await getTasks();
      _events = getEventMapFromTaskList(taskList);
      _isEventsLoad = true;
      notifyListeners();
    }
  }

  Map<DateTime, List<Task>> getEventMapFromTaskList(List<Task> _taskList) {
    Map<DateTime, List<Task>> _events = {};
    for (Task task in _taskList) {
      if (_events.containsKey(
          DateTime(task.date.year, task.date.month, task.date.day))) {
        _events[DateTime(task.date.year, task.date.month, task.date.day)]
            .add(task);
      } else {
        _events[DateTime(task.date.year, task.date.month, task.date.day)] = [
          task
        ];
      }
    }
    return _events;
  }
}
