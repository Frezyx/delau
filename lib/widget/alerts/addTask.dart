import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/templates/radio.dart';
import 'package:delau/widget/alerts/alertManager.dart';
import 'package:delau/widget/inputs/customRadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddTaskAlert extends StatefulWidget{
  @override
  _AddTaskAlertState createState() => _AddTaskAlertState();
}

class _AddTaskAlertState extends State<AddTaskAlert> {
  var task = Task();
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {

      sampleData.add(new RadioModel(0, true, FontAwesome.book, 'Учеба'));
      sampleData.add(new RadioModel(1, false, FontAwesome.briefcase, 'Работа'));
      sampleData.add(new RadioModel(2, false, MdiIcons.fromString('basketball'), 'Спорт'));
      sampleData.add(new RadioModel(3, false, FontAwesome.users, 'Встречи'));
      sampleData.add(new RadioModel(4, false, MdiIcons.fromString('shopping'), 'Покупки'));
      sampleData.add(new RadioModel(5, false, FontAwesome.spinner, 'Другое'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          Padding(
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
            ),
            buildMarkerPicker(),
        ],
      )
      );
    }

  Container buildMarkerPicker() {
    return Container(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sampleData.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {

                  },
                  splashColor: DesignTheme.mainColor,
                  child: getCustomRadio(sampleData[i], sampleData.length),
                );
              }
            ),
          );
  }

  Widget buildDescriptionTextField(){
    return TextFormField(
            key: Key('description_task'),
            onTap: (){},
            cursorColor: DesignTheme.mainColor,
            decoration: InputDecoration(
              contentPadding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
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
                      AlertManager.getDatePickerAlert(context); 
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
                     AlertManager.getTimePickerAlert(context);
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
                      print( await AlertManager.getPriorityPicker(context)); 
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