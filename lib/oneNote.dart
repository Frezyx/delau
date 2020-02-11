import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:delau/utils/allIconsList.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotePage extends StatefulWidget{
  String _id;

  NotePage({String id,}): _id = id;

  @override
  _NotePageState createState() => _NotePageState(_id);
}

class _NotePageState extends State<NotePage> {
  String id;
  bool sender = true;

    void setSender() {
      setState(() {
        sender = false;
      });
    }

  _NotePageState(this.id);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top:MediaQuery.of(context).size.height/5, bottom: MediaQuery.of(context).size.height/10),// color: Colors.transparent,
              child: new Form(key: _formKey, child: Column(children: <Widget>[ 
              TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (text) {
                  postNote(text);
                },
              )
                
            ],
          ),
        ),
      ),
  
    );
  }
  postNote(text){
                  if(!sender){
                    print("First text field: $text");
                    DBNoteProvider.db.updateNote(text, int.parse(id)).then((res){
                      print(res.toString() + "Обновил");
                    });
                  }
                  if(sender){
                    DBNoteProvider.db.addNote(text).then((res){
                      setSender();
                      id = res.toString();
                      print(res.toString() + "Добавил");
                    });
                  }
                  else{
                    print("Дурак");
                  }
  }
}