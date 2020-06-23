import 'package:delau/blocs/listItemBloc.dart';
import 'package:delau/design/custonDesignIcon.dart';
import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineStateCheckedIcons extends StatelessWidget {

  LineStateCheckedIcons({
    Key key,
    this.iconSize,
    this.index,
    this.listLength,
    this.isFinish,
  }) : super(key: key);

  double iconSize;
  int index;
  int listLength;
  bool isFinish;

  @override
  Widget build(BuildContext context) {

    final listItemBlocState = Provider.of<ListItemBloc>(context);

    return Container(
        decoration: CustomIconDecoration(
            iconSize: iconSize,
            lineWidth: 1,
            firstData: index == 0 ?? true,
            lastData: index == listLength - 1 ?? true),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color:  listItemBlocState.selectedEvents[index].isChecked?
                  Colors.green.withOpacity(0.2) :
                  DesignTheme.mainColor.withOpacity(0.2),
                  offset: Offset(0.0, 1.0),
                  spreadRadius: 3.0,
                  blurRadius: 6.0,
                ),
              ]),
          child: Icon(
              isFinish
                  ? Icons.fiber_manual_record
                  : Icons.radio_button_unchecked,
              size: iconSize,
              color: listItemBlocState.selectedEvents[index].isChecked? Colors.green :
              DesignTheme.mainColor),
        ));
  }
}