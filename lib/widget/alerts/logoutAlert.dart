import 'package:flutter/material.dart';

Future<void> getAlert(context, alertText, List<Widget> buttons) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(alertText),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          actions: buttons);
    },
  );
}
