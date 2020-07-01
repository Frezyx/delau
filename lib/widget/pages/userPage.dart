import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';

getPhoto(double screenHeight, double screenWidth) {
  var imgContainerWidth = screenWidth / 2.2;
  var imgContainerHeight = imgContainerWidth;

  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: imgContainerWidth,
    height: imgContainerHeight,
    decoration: new BoxDecoration(
      gradient: DesignTheme.imgCircleGradient,
      borderRadius: new BorderRadius.circular(imgContainerWidth),
    ),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 600),
      margin: EdgeInsets.all(12.5),
      width: imgContainerWidth,
      height: imgContainerHeight,
      decoration: new BoxDecoration(
        color: DesignTheme.mainColor,
        borderRadius: new BorderRadius.circular(imgContainerWidth),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 900),
        margin: EdgeInsets.all(10),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: new NetworkImage(
                  "https://avatars.mds.yandex.net/get-pdb/1779125/deed738a-66f5-46d0-b3c6-020dff434219/s1200")),
        ),
      ),
    ),
  );
}
