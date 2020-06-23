import 'package:delau/design/lineBetweenIcons.dart';
import 'package:flutter/material.dart';

class CustomIconDecoration extends Decoration {
  final double iconSize;
  final double lineWidth;
  final bool firstData;
  final bool lastData;

  CustomIconDecoration({
    @required double iconSize,
    @required double lineWidth,
    @required bool firstData,
    @required bool lastData,
  })  : this.iconSize = iconSize,
        this.lineWidth = lineWidth,
        this.firstData = firstData,
        this.lastData = lastData;

  @override
  BoxPainter createBoxPainter([onChanged]) {
    return LineBetweenIcons(
        iconSize: iconSize,
        lineWidth: lineWidth,
        firstData: firstData,
        lastData: lastData
      );
    }
  }