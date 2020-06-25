import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/templates/radio.dart';
import 'package:delau/widget/alerts/alertManager.dart';
import 'package:delau/widget/inputs/customRadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddNoteAlert extends StatefulWidget{
  @override
  _AddNoteAlertState createState() => _AddNoteAlertState();
}

class _AddNoteAlertState extends State<AddNoteAlert> {
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
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 14.0, top: 4.0, left: 8.0, right: 8.0),
                  child: Text("Добавление заметки", style: DesignTheme.alert.bigText,),
                ),
                buildTitleTextField(),
                buildMarkerPicker(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getBottomButton("Отменить", Icons.add, Colors.red, context),
                    getBottomButton("Сохранить", Icons.add, DesignTheme.mainColor, context),
                  ]
                ),
              ]),
            ),
        ],
      )
      );
    }

getBottomButton(String text, IconData icon, Color color, BuildContext context){
    return    Padding(
                padding:EdgeInsets.only(left: 5, right: 5, bottom: 20),
                child:
                    OutlineButton(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      highlightColor: Colors.white,
                      splashColor: color,
                      onPressed: (){ },
                      child: 
                      Padding(
                        padding:EdgeInsets.all(5),
                        child:Stack(
                          children: <Widget>[
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

  Widget buildMarkerPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Выберите маркер", style:DesignTheme.alert.label),
        ),
        Container(
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
              ),
      ],
    );
  }


  Widget buildTitleTextField() {
    return TextFormField(
            key: Key('title_task'),
            onTap: (){},
            minLines: 10,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            cursorColor: DesignTheme.mainColor,
            decoration: InputDecoration(
              hintText: "Введите вашу заметку",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignTheme.normalBorderRadius),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
            ),
            validator: (value){
              if (value.isEmpty) return 'Введите вашу заметку';
              else { task.name = value.toString(); }
            },
          );
  }
}