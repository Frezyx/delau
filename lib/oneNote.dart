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
  final TextEditingController _inputController = new TextEditingController( );
  String id;
  bool sender = true;

    void setSender() {
      setState(() {
        sender = false;
      });
    }

    @override
    void initState(){
      super.initState();
      if(id != "none"){
        DBNoteProvider.db.getNoteById(int.parse(id)).then((note){
          _inputController.text = note;
        });
      }
    }

  _NotePageState(this.id);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top:MediaQuery.of(context).size.height/5, bottom: 10),// color: Colors.transparent,
              child: new Form(key: _formKey, child: Column(children: <Widget>[ 
              TextField(
                controller: _inputController,
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
      Padding(
    padding: EdgeInsets.only(right: 45.0, left: 45.0),
    child:
Container(
  child:
  RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/notes');
                        },
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  padding: const EdgeInsets.all(0.0),
  child: Ink(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
                      colors: [
                      Color.fromRGBO(162, 122, 246, 1),
                      Color.fromRGBO(114, 103, 239, 1),
                      // Color.fromRGBO(81, 20, 219, 1),
                      // Color.fromRGBO(31, 248, 169, 1),
                      ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    child: Container(
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 40.0), // min sizes for Material buttons
      alignment: Alignment.center,
      child: Text('Назад', textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.white),),
      ),
    ),
  ),
  ),
),
      Text(
        "*Изменения сохраняются автоматически",
        style: TextStyle(color: Color.fromRGBO(114, 103, 239, 1),),

      ),
     
        ],
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