import 'package:delau/models/templates/UserParams.dart';
import 'package:delau/models/user.dart';
import 'package:delau/utils/provider/own_api/prepare/getUser.dart';
import 'package:delau/utils/provider/own_api/prepare/getUserTaskParams.dart';
import 'package:flutter/material.dart';

class UserPageBloc extends ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  bool _isEdit = false;

  bool get isEdit => _isEdit;

  set isEdit(bool val) {
    _isEdit = val;
    notifyListeners();
  }

  bool _isDataLoad = false;

  bool get isDataLoad => _isDataLoad;

  bool _isTelegramNotifyOn = false;

  bool get isTelegramNotifyOn => _isTelegramNotifyOn;

  set isTelegramNotifyOn(bool val) {
    _isTelegramNotifyOn = val;
    notifyListeners();
  }

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

  bool _isParamDataLoad = false;

  bool get isParamDataLoad => _isParamDataLoad;

  bool _isParamLoad = false;

  bool get isParamLoad => _isParamLoad;

  UserParams _userParams = UserParams();

  UserParams get userParams => _userParams;

  loadUserParamsData() async {
    if (!_isParamDataLoad) {
      _isParamDataLoad = true;
      notifyListeners();
      _userParams = await getUserParams();
      if (_userParams != null) {
        _isParamLoad = true;
      }
      notifyListeners();
    }
  }
}
