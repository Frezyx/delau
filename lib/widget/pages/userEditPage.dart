import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

getPhotoButton() {
  return Container(
      margin: EdgeInsets.only(top: 110, left: 100, right: 10),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: new BoxDecoration(
            boxShadow: DesignTheme.buttons.selectedTabHomeShadow,
            color: DesignTheme.mainColor,
            // gradient: DesignTheme.imgCircleGradient,
            border: Border.all(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                FontAwesomeIcons.camera,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
}
