import 'package:delau/design/theme.dart';
import 'package:delau/utils/convert/epochFromDate.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:delau/widget/alerts/logoutAlert.dart';
import 'package:delau/widget/buttons/allertButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';

class AlertManager {
  static Future<TimeOfDay> getTimePickerAlert(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) return picked;
    return null;
  }

  static Future<DateTime> getDatePickerAlert(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      return picked;
    } else
      return null;
  }

  static getLogoutAlert(context) {
    List<Widget> buttons = [
      getBottomButton(
          "Отменить", Icons.add, Colors.red, context, close, true, null),
      getBottomButton("Выйти", Icons.add, DesignTheme.mainColor, context,
          logout, false, context),
    ];
    return getAlert(
        context, "Вы действительно хотите выйти из аккаунта ?", buttons);
  }

  static close(context) {
    Navigator.pop(context);
  }

  static logout(context) {
    // ServerProvider.authHandler
    //     .logoutUser(user.authToken)
    //     .then((res) {
    //   if (res) {
    UserDB.udb.userLogOut().then((res) {
      if (res) {
        Navigator.popAndPushNamed(context, '/');
      }
    });
    //   }
    // });
  }
}
