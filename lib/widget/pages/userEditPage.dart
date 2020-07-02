import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

getPhotoButton() {
  return Container(
      margin: EdgeInsets.all(0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: new BoxDecoration(
            boxShadow: DesignTheme.buttons.selectedTabHomeShadow,
            color: DesignTheme.mainColor.withOpacity(0.2),
            // gradient: DesignTheme.imgCircleGradient,
            border: Border.all(
              color: Colors.transparent,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(200),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                FontAwesomeIcons.camera,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
}
