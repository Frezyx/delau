import 'package:delau/design/alert.dart';
import 'package:delau/design/appBar.dart';
import 'package:delau/design/buttons.dart';
import 'package:delau/design/icons.dart';
import 'package:delau/design/sizeHelper.dart';
import 'package:flutter/material.dart';

class DesignTheme {
  DesignTheme._();

  static final ButtonsTheme buttons = ButtonsTheme();
  static final SizeHelper size = SizeHelper();
  static final AlertTheme alert = AlertTheme();
  static final AppBarCustomTheme appbar = AppBarCustomTheme();
  static final CustomIcons icons = CustomIcons();

  static const Color mainColor = Color.fromRGBO(0, 159, 253, 1);
  static const Color secondColor = Color.fromRGBO(42, 42, 114, 1);

  static const Color blueGrey = Color.fromRGBO(188, 214, 229, 1);
  static const Color blueGreyDark = Color.fromRGBO(145, 173, 189, 1);

  static const Color greyMedium = Color.fromRGBO(164, 164, 164, 1);
  static const Color greyLight = Color.fromRGBO(194, 194, 194, 1);
  static const Color greyLighterThenMedium = Color.fromRGBO(183, 183, 183, 1);
  static const Color greyDark = Color.fromRGBO(120, 120, 120, 1);
  static const Color greyDarker = Color.fromRGBO(105, 105, 105, 1);
  static const Color greyLastDarker = Color.fromRGBO(55, 55, 55, 1);

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

  static const TextStyle listItemLabel = TextStyle(
    fontSize: 18.0,
    color: Colors.black87,
  );

  static const TextStyle listItemLabelChecked = TextStyle(
    fontSize: 18.0,
    color: DesignTheme.greyMedium,
  );

  static const TextStyle listItemLabelBig = TextStyle(
    fontSize: 20.0,
    color: Colors.black87,
  );

  static const TextStyle listItemSubtitle = TextStyle(
    fontSize: 12.0,
    color: DesignTheme.greyMedium,
  );

  static const TextStyle listTime = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: DesignTheme.greyDark,
  );

  static const TextStyle markerThemeText = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
      color: DesignTheme.mainColor);

  static const TextStyle markerThemeFieldText = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
      color: DesignTheme.greyMedium);

// Task list text styles end

// Notes page

  static const TextStyle bigWhite = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle notesSearchText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
    color: DesignTheme.greyMedium,
  );

  static List<BoxShadow> searchFormShadow = [
    BoxShadow(
      color: DesignTheme.secondColor.withOpacity(0.35),
      blurRadius: 20.0,
      spreadRadius: 2.0,
      offset: Offset(
        10.0,
        10.0,
      ),
    )
  ];

// Notes page end

// Home page

  static const TextStyle telegramBanerMainText = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: DesignTheme.mainColor);

  static const TextStyle telegramBanerSecondText = TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w300,
      color: DesignTheme.greyMedium);

  static const TextStyle biggerWhite = TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.w900,
    color: Colors.white,
  );

  static const TextStyle midleWhiteBold = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle midleWhiteLight = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w100,
    color: Colors.white,
  );

  static const TextStyle bigItemLabel = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle lilItemLabel = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w300,
    color: Colors.grey,
  );

  static const TextStyle itemTime = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: DesignTheme.mainColor,
  );

  static const TextStyle themeText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: DesignTheme.greyDark,
  );

  static const TextStyle carouselLabel = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w200,
    color: DesignTheme.greyDark,
  );

  static const TextStyle carouselUnderLabel = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w200,
    color: DesignTheme.greyLighterThenMedium,
  );

// Home page end

  static const TextStyle infoCardText = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
    color: DesignTheme.mainColor,
  );

  static const TextStyle infoCardUnderLineText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: DesignTheme.greyLighterThenMedium,
  );

  static const TextStyle userPageName = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle userPageEmail = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
    color: DesignTheme.greyDark,
  );

  static const TextStyle appBarText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22,
    letterSpacing: 0.2,
    color: DesignTheme.greyLighterThenMedium,
  );

  static const TextStyle typeFieldText = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: DesignTheme.mainColor,
  );

  static const TextStyle notifyText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
    color: DesignTheme.greyLight,
  );

  static const TextStyle textFieldLabel = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w300,
    color: DesignTheme.mainColor,
  );

  static const TextStyle valueFieldText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w200,
    color: DesignTheme.greyMedium,
  );

  static const TextStyle authText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w200,
    color: DesignTheme.greyMedium,
  );

  static const TextStyle bigBlueText = TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.w900,
    color: DesignTheme.mainColor,
  );

  static const LinearGradient gradientButton = LinearGradient(
    colors: [DesignTheme.secondColor, DesignTheme.mainColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient imgCircleGradient = LinearGradient(
    colors: [
      DesignTheme.mainColor.withOpacity(0.22),
      DesignTheme.mainColor.withOpacity(0.5)
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
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
