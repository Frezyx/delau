import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/templates/radio.dart';
import 'package:delau/utils/iconList.dart';
import 'package:delau/widget/inputs/customRadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddMarkerAlert extends StatefulWidget{
  @override
  _AddMarkerAlertState createState() => _AddMarkerAlertState();
}

class _AddMarkerAlertState extends State<AddMarkerAlert> {
  var task = Task();
  List<RadioModel> sampleData = new List<RadioModel>();
  ScrollController scrollController;

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
                  child: Text("Добавление маркера", style: DesignTheme.alert.bigText,),
                ),
                buildTitleTextField(),

                Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: Expanded(
                    child: StaggeredGridView.countBuilder(
                      controller: scrollController,
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 5,
                      itemCount: iconsMaterial.length,
                      itemBuilder: (context, i){
                        return getMarkerButton(iconsMaterial, i);
                      },
                      staggeredTileBuilder: (int i) => StaggeredTile.count(1,1)),
                  ),
                ),

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

getMarkerButton(iconsMaterial, i){
  return  OutlineButton(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      highlightColor: Colors.white,
                      splashColor: DesignTheme.mainColor,
                      onPressed: (){ 

                       },
                      child: 
                      Padding(
                        padding:EdgeInsets.only(bottom: 5, top: 5),
                        child:Icon(
                          MdiIcons.fromString(iconsMaterial[i]),
                          color: DesignTheme.greyMedium,
                        )
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

  Widget buildTitleTextField() {
    return TextFormField(
            key: Key('title_task'),
            onTap: (){},
            cursorColor: DesignTheme.mainColor,
            decoration: InputDecoration(
              hintText: "Назовите свой маркер",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignTheme.normalBorderRadius),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
            ),
            validator: (value){
              if (value.isEmpty) return 'Введите название маркера';
              else { task.name = value.toString(); }
            },
          );
  }
}