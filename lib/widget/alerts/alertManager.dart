import 'package:delau/design/theme.dart';
import 'package:delau/utils/convert/epochFromDate.dart';
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
}
