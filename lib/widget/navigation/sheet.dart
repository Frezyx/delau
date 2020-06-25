import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/templates/radio.dart';
import 'package:delau/widget/alerts/addTask.dart';
import 'package:delau/widget/alerts/alertManager.dart';
import 'package:delau/widget/inputs/customRadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SheetOfBottomBar extends StatefulWidget{
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
            padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                getBottomButton("Добавить задачу", Icons.add, DesignTheme.mainColor, context),
                getBottomButton("Добавить заметку", Icons.list, DesignTheme.mainColor, context),
                getBottomButton("Добавить маркер", Icons.label, DesignTheme.mainColor, context),
              ]),
            ),
        ],
      )
    );
  }
}

getBottomButton(String text, IconData icon, Color color, BuildContext context){
    return    Padding(
                padding:EdgeInsets.only(left:10, right: 10, bottom: 20),
                child:
                    OutlineButton(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      highlightColor: Colors.white,
                      splashColor: color,
                      onPressed: (){ 
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                clipBehavior: Clip.hardEdge,
                                insetAnimationDuration: const Duration(milliseconds: 300),
                                child: AddTaskAlert(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5))));
                        });
                       },
                      child: 
                      Padding(
                        padding:EdgeInsets.only(left:10, right: 10, bottom: 10, top: 13),
                        child:Stack(
                          children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(icon, color: color)
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      text,
                                      style: TextStyle(
                                        color:color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                        ),
                                      textAlign: TextAlign.center,
                                  )
                              )
                          ],
                      ),
                      ),
                      highlightedBorderColor: color,
                      borderSide: new BorderSide(color:color),
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(DesignTheme.normalBorderRadius)
                      )
                  )
                  );
  }