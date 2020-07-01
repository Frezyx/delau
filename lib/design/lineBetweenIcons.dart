import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';

class LineBetweenIcons extends BoxPainter {

  final double iconSize;
  final bool firstData;
  final bool lastData;
  final Paint paintLine;

  LineBetweenIcons({
    @required double iconSize,
    @required double lineWidth,
    @required bool firstData,
    @required bool lastData,
  })  : this.iconSize = iconSize,
        this.firstData = firstData,
        this.lastData = lastData,
        paintLine = Paint()
          ..color = DesignTheme.greyMedium
          ..strokeCap = StrokeCap.round
          ..strokeWidth = lineWidth
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

    final leftOffset = Offset((iconSize / 2) + 24, offset.dy);
    final double iconSpace = iconSize / 1.5;
    final Offset top = configuration.size.topLeft(Offset(leftOffset.dx, 0.0));
    final Offset centerTop = configuration.size.centerLeft(Offset(leftOffset.dx, leftOffset.dy - iconSpace));
    final Offset centerBottom = configuration.size.centerLeft(Offset(leftOffset.dx, leftOffset.dy + iconSpace));
    final Offset end = configuration.size.bottomLeft(Offset(leftOffset.dx, leftOffset.dy * 2));

    if (!firstData) canvas.drawLine(top, centerTop, paintLine);
    if (!lastData) canvas.drawLine(centerBottom, end, paintLine);
  }
}