import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';

class ButtonsTheme {

  static const Color _color = Colors.white;
  
  TextStyle text = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: ButtonsTheme._color,
  );

  List<BoxShadow> selectedTabHomeShadow = [
    BoxShadow(
      color: DesignTheme.mainColor.withOpacity(0.2),
      offset: Offset(0.0, 3.0),
        blurRadius: 15.0,
      ),
    ];
  
  List<BoxShadow> tabHomeShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.03),
      offset: Offset(0.0, 3.0),
        blurRadius: 15.0,
      ),
    ];

  TextStyle selectedTabText =TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  TextStyle tabText =TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

}