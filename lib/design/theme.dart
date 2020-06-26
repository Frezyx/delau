import 'package:delau/design/alert.dart';
import 'package:delau/design/buttons.dart';
import 'package:delau/design/sizeHelper.dart';
import 'package:flutter/material.dart';

class DesignTheme {
  DesignTheme._();

  static final ButtonsTheme buttons = ButtonsTheme();
  static final SizeHelper size = SizeHelper();
  static final AlertTheme alert = AlertTheme();

  static const Color mainColor = Color.fromRGBO(0, 159, 253, 1);
  static const Color secondColor = Color.fromRGBO(42, 42, 114, 1);

  static const Color blueGrey = Color.fromRGBO(188, 214, 229, 1);
  static const Color blueGreyDark = Color.fromRGBO(145, 173, 189, 1);
  static const Color greyMedium = Color.fromRGBO(164, 164, 164, 1);
  static const Color greyLight = Color.fromRGBO(194, 194, 194, 1);
  static const Color greyDark = Color.fromRGBO(120, 120, 120, 1);

  static const double normalBorderRadius = 5;

  static const Color bgColor = Color.fromRGBO(244, 244, 244, 1);

  static ThemeData appTheme = ThemeData(
        backgroundColor: DesignTheme.bgColor,
        fontFamily: 'Ubuntu',
        accentColor: DesignTheme.mainColor,
        primaryColorLight: DesignTheme.mainColor,
        primarySwatch: Colors.blue,
      );

// Task list text styles

  static const TextStyle listItemLabel =TextStyle(
      fontSize: 18.0,
      color: Colors.black87,
    );

  static const TextStyle listItemLabelChecked =TextStyle(
      fontSize: 18.0,
      color: DesignTheme.greyDark,
    );
  
  static const TextStyle listItemLabelBig =TextStyle(
      fontSize: 20.0,
      color: Colors.black87,
    );

  static const TextStyle listItemSubtitle =TextStyle(
    fontSize: 12.0,
    color: DesignTheme.greyMedium,
  );

  static const TextStyle listTime =TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: DesignTheme.greyDark,
  );

// Task list text styles end

// Notes page 

  static const TextStyle bigWhite =TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle notesSearchText =TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
    color: DesignTheme.greyMedium,
  );

  static List<BoxShadow> searchFormShadow = [
    BoxShadow(
      color: DesignTheme.secondColor.withOpacity(0.35),
      blurRadius: 20.0, 
      spreadRadius: 2.0,
      offset: Offset(10.0, 10.0,),
    )
  ];

// Notes page end

  static const LinearGradient 
    gradientButton = LinearGradient(
    colors: [
      DesignTheme.secondColor,
      DesignTheme.mainColor
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
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