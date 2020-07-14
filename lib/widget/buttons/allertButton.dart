import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';

getBottomButton(String text, IconData icon, Color color, BuildContext context,
    Function func, bool isClose, _formKey) {
  return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 20),
      child: OutlineButton(
          hoverColor: Colors.white,
          focusColor: Colors.white,
          highlightColor: Colors.white,
          splashColor: color,
          onPressed: () {
            if (isClose) {
              func(context);
            } else {
              func(_formKey);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: TextStyle(
                          color: color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
          highlightedBorderColor: color,
          borderSide: new BorderSide(color: color),
          shape: new RoundedRectangleBorder(
              borderRadius:
                  new BorderRadius.circular(DesignTheme.normalBorderRadius))));
}
