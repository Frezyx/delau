import 'package:flutter/material.dart';

class DesignTheme {
  DesignTheme._();

static const Color mainColor = Color.fromRGBO(0, 159, 253, 1);
static const Color secondColor = Color.fromRGBO(42, 42, 114, 1);
static const Color blueGray = Color.fromRGBO(188, 214, 229, 1);

  static const LinearGradient 
    mainGradient = LinearGradient(
      colors: [
        DesignTheme.mainColor,
        DesignTheme.secondColor,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.13,1.03],
      tileMode: TileMode.clamp
  );

      static const BoxShadow originalShadowLil = BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.06),
                            blurRadius: 5.0,
                            spreadRadius: 0.7,
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          );

}