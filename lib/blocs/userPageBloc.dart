import 'package:flutter/material.dart';

class UserPageBloc extends ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }
}
