import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/widget/alerts/alertManager.dart';
import 'package:flutter/material.dart';

class SheetOfBottomBar extends StatefulWidget{
  @override
  _SheetOfBottomBarState createState() => _SheetOfBottomBarState();
}

class _SheetOfBottomBarState extends State<SheetOfBottomBar> {
  var task = Task();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
        child: Column(
          children: <Widget>[
            buildTitleTextField(),
            SizedBox(height: 5),
            buildDescriptionTextField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildPriorityButton(context),
                buildTimeButton(context),
                buildDateButton(context),
              ],
            ),
          ]),
        )
      );
    }

  Widget buildDescriptionTextField(){
    return TextFormField(
            key: Key('description_task'),
            onTap: (){},
            cursorColor: DesignTheme.mainColor,
            decoration: InputDecoration(
              hintText: "Пояснение задачи",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
            ),
            validator: (value){
              if (value.isEmpty) return 'Введите пояснение задачи';
              else { task.name = value.toString(); }
            },
          );
    }

  Widget buildTitleTextField() {
    return TextFormField(
            key: Key('title_task'),
            onTap: (){},
            cursorColor: DesignTheme.mainColor,
            decoration: InputDecoration(
              hintText: "Название задачи",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
            ),
            validator: (value){
              if (value.isEmpty) return 'Введите название задачи';
              else { task.name = value.toString(); }
            },
          );
  }

  Widget buildDateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 1, color: DesignTheme.mainColor),
      ),
      child: FlatButton(
                    color: Colors.transparent, 
                    textColor: DesignTheme.mainColor,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    onPressed: () { 
                      AlertManager.getDatePikerAlert(context); 
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.date_range,size: 28.0,),
                        SizedBox(height: 7),
                        Text(
                            "Дата",
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500,),
                          ),    
                      ],
                    ),
                  ),
    );
  }

  Widget buildTimeButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only( left: 5.0, top: 5, right: 5.0, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 1, color: DesignTheme.mainColor),
      ),
      child: FlatButton(
                    color: Colors.transparent, 
                    textColor: DesignTheme.mainColor,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    onPressed: () {
                     AlertManager.getTimePikerAlert(context);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.timer,size: 28.0,),
                        SizedBox(height: 7),
                        Text(
                            "Вермя",
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500,),
                          ),
                      ],
                    ),
                  ),
    );
  }

  Widget buildPriorityButton(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(right: 10.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 1, color: DesignTheme.mainColor),
      ),

      child: FlatButton(
                    color: Colors.transparent,
                    textColor: DesignTheme.mainColor,
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, ),
                    onPressed: () async{ 
                      print( await AlertManager.getPriorityPiker(context)); 
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.star,size: 28.0,),
                        SizedBox(height: 7),
                          Text("Приоритет",
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500,),
                          ),
                      ],
                    ),
                  ),
    );
  }
}