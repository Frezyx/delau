import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';

getAppBar(String text, context) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 28,
          color: DesignTheme.greyLighterThenMedium,
        )),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    title: Text(text, style: DesignTheme.appBarText),
  );
}
