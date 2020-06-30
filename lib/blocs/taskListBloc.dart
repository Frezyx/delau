import 'package:delau/models/task.dart';
import 'package:flutter/material.dart';

class TaskListBloc extends ChangeNotifier {
  bool _isDataLoaded = false;
  List _tasks = [];

  List get tasks => _tasks;
  bool get isDataLoaded => _isDataLoaded;

  set tasks(List val) {
    _tasks = val;
    _isDataLoaded = true;
    notifyListeners();
  }

  void addNote(Task task) {
    _tasks.add(task);
    notifyListeners();
  }
}
