import 'package:delau/design/theme.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:delau/widget/alerts/alertManager.dart';
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
    title: Text(
      text,
      style: DesignTheme.appbar.textFieldLabel,
      overflow: TextOverflow.fade,
    ),
  );
}

getUserAppBar(String text, context) {
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
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: DesignTheme.appbar.textFieldLabel,
              overflow: TextOverflow.fade,
            ),
            IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: DesignTheme.greyLighterThenMedium,
                ),
                onPressed: () {
                  AlertManager.getLogoutAlert(context);
                })
          ]));
}
