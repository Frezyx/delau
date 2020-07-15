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

  int _selectedTap = 0;
  int get selectedTap => _selectedTap;
  set selectedTap(int val) {
    _selectedTap = val;
    notifyListeners();
  }

  String _marker = "";
  String get marker => _marker;
  set marker(String val) {
    _marker = val;
    notifyListeners();
  }

  String _markerIcon = "";
  String get markerIcon => _markerIcon;
  set markerIcon(String val) {
    _markerIcon = val;
    notifyListeners();
  }

  void openMarker(String markerName, String markerIcon) {
    _marker = markerName;
    _markerIcon = markerIcon;
    _isMarkerOpened = true;
    notifyListeners();
  }

  void closeMarker() {
    _marker = "";
    _markerIcon = "";
    _isMarkerOpened = false;
    notifyListeners();
  }

  bool _isMarkerOpened = false;
  bool get isMarkerOpened => _isMarkerOpened;
  set isMarkerOpened(bool val) {
    _isMarkerOpened = val;
    notifyListeners();
  }
}
