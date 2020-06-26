import 'package:delau/blocs/notesListBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/templates/radio.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/widget/alerts/alertManager.dart';
import 'package:delau/widget/inputs/customRadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AddNoteAlert extends StatefulWidget{
  @override
  _AddNoteAlertState createState() => _AddNoteAlertState();
}

class _AddNoteAlertState extends State<AddNoteAlert> {

  String noteText;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final noteListBloc = Provider.of<NotesListBloc>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          Form(key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0, top: 4.0, left: 8.0, right: 8.0),
                    child: Text("Добавление заметки", style: DesignTheme.alert.bigText,),
                  ),
                  buildTitleTextField(noteListBloc),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      getBottomButton("Отменить", Icons.add, Colors.red, context, close, true, _formKey),
                      getBottomButton("Сохранить", Icons.add, DesignTheme.mainColor, context, validate, false, _formKey),
                    ]
                  ),
                ]),
              ),
          ),
        ],
      )
      );
    }

validate(_formKey){
  _formKey.currentState.validate();
}

close( context){
  Navigator.pop(context);
}

getBottomButton(String text, IconData icon, Color color, BuildContext context, Function func, bool isClose, _formKey){
    return    Padding(
                padding:EdgeInsets.only(left: 5, right: 5, bottom: 20),
                child:
                    OutlineButton(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      highlightColor: Colors.white,
                      splashColor: color,
                      onPressed: (){ 
                        if(isClose){
                          func(context);
                        }else{ 
                          func(_formKey);
                         }
                      },
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

  Widget buildTitleTextField(noteListBloc) {
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
              else { 
                DBNoteProvider.db.addNote(value.toString()).then((res){
                  noteListBloc.addNote(Note(id:res, isSelected: false));
                  Navigator.pop(context);
                });
              }
            },
          );
  }
}