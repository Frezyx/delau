import 'package:flutter/material.dart';

class ListItemBloc extends ChangeNotifier{

  List _selectedEvents = [ ];

  void changeCheckState(int index){
    _selectedEvents[index].isChecked = !_selectedEvents[index].isChecked;
    notifyListeners();
  }

  void changeOpenState(int index){
    _selectedEvents[index].isOpen = !_selectedEvents[index].isOpen;
    notifyListeners();
  }

  String getItemIcon(int index){
    return _selectedEvents[index].icon;
  }

  List get selectedEvents => _selectedEvents;

  set selectedEvents(List val) {
    _selectedEvents = val;
    notifyListeners();
  }

  
  
}