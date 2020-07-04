import 'package:delau/models/user.dart';
import 'package:delau/utils/provider/own_api/prepare/getUser.dart';
import 'package:flutter/material.dart';

class UserPageBloc extends ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  bool _isDataLoad = false;

  bool get isDataLoad => _isDataLoad;

  bool _isLoad = false;

  bool get isLoad => _isLoad;

  User _user = User();

  User get user => _user;

  loadUserData() async {
    if (!_isDataLoad) {
      _isDataLoad = true;
      notifyListeners();
      _user = await getEnteredUser();
      if (_user != null) {
        _isLoad = true;
      }
      notifyListeners();
    }
  }
}
