import 'package:flutter/material.dart';

class AuthPageBloc extends ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  bool _passwordCover = true;

  bool get passwordCover => _passwordCover;

  void setPasswordCover() {
    _passwordCover = !_passwordCover;
    notifyListeners();
  }
}
