import 'package:delau/design/theme.dart';
import 'package:delau/utils/convert/epochFromDate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';

class AlertManager {
  static Future<int> getTimePickerAlert(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    var dt = DateTime(0, 0, 0, picked.hour, picked.minute, 0, 0, 0);
    if (picked != null) return epochFromDate(dt);
    return null;
  }

  static Future<int> getDatePickerAlert(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      var date = DateTime(picked.year, picked.month, picked.day, 0, 0, 0, 0, 0);
      print(epochFromDate(date));
      return epochFromDate(date);
    } else
      return null;
  }
}
