import 'package:flutter/material.dart';

class ListItemBloc extends ChangeNotifier{
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  set isOpen(bool val) {
    _isOpen = val;
    notifyListeners();
  }

}