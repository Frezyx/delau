import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';

Widget displayTime(String time) {
  return Container(
      child: Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
    child: Text(
      time,
      style: DesignTheme.listTime,
      textAlign: TextAlign.center,
    ),
  ));
}
