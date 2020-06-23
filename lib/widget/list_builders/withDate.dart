import 'package:delau/blocs/listItemBloc.dart';
import 'package:delau/design/custonDesignIcon.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/models/provider/listItemState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListWithDateItem extends StatelessWidget {

  final int listPosition;
  final List<dynamic> data;
  ListItemBloc itemState;

  ListWithDateItem({
    Key key,
    @required this.listPosition,
    @required this.data,
    this.itemState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var topSpace = listPosition == 0 ? 22.0 : 9.0;
    var bottomSpace = listPosition == data.length - 1? 22.0 : 9.0;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: topSpace, bottom: bottomSpace),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: DesignTheme.mainColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(0.0, 3.0),
                  spreadRadius: 2.0,
                  blurRadius: 10.0,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                child: Icon(
                  Icons.bluetooth, 
                  color: DesignTheme.mainColor
                ),
              ),
              Container(
                width: 140,
                //Must be like widget.height - padding
                height: 40,
                // itemState.isOpen != null? itemState.isOpen? 40 : 100: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(listPosition.toString(), style: DesignTheme.listItemLabel),
                    Expanded(child: Text(data[listPosition].toString(), style: DesignTheme.listItemSubtitle, overflow: TextOverflow.ellipsis),),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                child: Checkbox(
                    onChanged: (bool value) {

                    },
                  value: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  Widget displayTime(String time) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(time, style: DesignTheme.listTime, textAlign: TextAlign.center,),
        ));
  }

  Widget lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish) {
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
                  color: DesignTheme.mainColor.withOpacity(0.2),
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
              color: DesignTheme.mainColor),
        ));
  }