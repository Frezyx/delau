import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/templates/radio.dart';
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
            padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                getEditingButton("Добавить задачу", Icons.add),
                getEditingButton("Добавить заметку", Icons.list),
                getEditingButton("Добавить маркер", Icons.label),
              ]),
            ),
        ],
      )
    );
  }
}

getEditingButton(String text, IconData icon){
    return    Padding(
                padding:EdgeInsets.only(left:10, right: 10, bottom: 20),
                child:
                    OutlineButton(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      highlightColor: Colors.white,
                      splashColor: DesignTheme.mainColor,
                      onPressed: (){  },
                      child: 
                      Padding(
                        padding:EdgeInsets.only(left:10, right: 10, bottom: 10, top: 13),
                        child:Stack(
                          children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(icon, color: DesignTheme.mainColor)
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      text,
                                      style: TextStyle(
                                        color:DesignTheme.mainColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                        ),
                                      textAlign: TextAlign.center,
                                  )
                              )
                          ],
                      ),
                      ),
                      highlightedBorderColor: DesignTheme.mainColor,
                      borderSide: new BorderSide(color:DesignTheme.mainColor),
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)
                      )
                  )
                  );
  }