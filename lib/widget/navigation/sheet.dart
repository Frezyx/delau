import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/templates/radio.dart';
import 'package:delau/widget/alerts/addMarker.dart';
import 'package:delau/widget/alerts/addNote.dart';
import 'package:delau/widget/alerts/addTask.dart';
import 'package:delau/widget/alerts/alertManager.dart';
import 'package:delau/widget/alerts/bottomAlerts.dart';
import 'package:delau/widget/inputs/customRadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SheetOfBottomBar extends StatefulWidget {
  @override
  _SheetOfBottomBarState createState() => _SheetOfBottomBarState();
}

class _SheetOfBottomBarState extends State<SheetOfBottomBar> {
  var alerts = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 14, right: 14),
          child: Column(children: <Widget>[
            getBottomButton("Добавить задачу ", context, getTaskCreateAlert, 1,
                null, SvgPicture.asset('assets/svg/sheet/checklist.svg'), 35),
            getBottomButton("Добавить заметку", context, getNoteCreateAlert, 1,
                null, SvgPicture.asset('assets/svg/sheet/write.svg'), 35),
            getBottomButton("Добавить маркер ", context, getMarkerCreateAlert,
                1, null, SvgPicture.asset('assets/svg/sheet/marker.svg'), 35),
          ]),
        ),
      ],
    ));
  }
}

getBottomButton(String text, BuildContext context, Function func, int pageIndex,
    DateTime date, Widget image, double containerSize) {
  return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.height / 15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(30.0),
                  boxShadow: DesignTheme.buttons.sheetButtonShadow,
                ),
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child:
                        Text(text, style: DesignTheme.buttons.sheetButtonText),
                  ),
                  onPressed: () {
                    func(context, pageIndex, date);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
          ClipOval(
            child: Material(
              color: Colors.blue, // button color
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: containerSize,
                  height: containerSize,
                  child: image,
                ),
              ),
            ),
          ),
        ],
      ));
}
