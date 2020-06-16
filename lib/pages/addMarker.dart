import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:delau/utils/allIconsList.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddMarkerPage extends StatefulWidget{
  String _id;
  String _icon;

  AddMarkerPage({String id, String icon}): _id = id, _icon = icon;

  @override
  _AddMarkerPageState createState() => _AddMarkerPageState(_id, _icon);
}

class _AddMarkerPageState extends State<AddMarkerPage> {
  String id;
  String icon;

  _AddMarkerPageState(this.id, this.icon);

  final _formKey = GlobalKey<FormState>();
  String _name;

  var rng = new Random();

  getCustomRadio(String icon){
    return
      InkWell(
    onTap:() {
       Navigator.pushNamed(context, '/icon');
    },
    child: 
    new Container(
        margin: new EdgeInsets.all(15.0),
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.width/2.3,
              width: MediaQuery.of(context).size.width/2.3,
              child: new Center(
                child: Icon( MdiIcons.fromString( icon ?? "flagPlus"),
                color: Color.fromRGBO(114, 103, 239, 1),
                size: MediaQuery.of(context).size.width/3.3,),
              ),
               decoration: new BoxDecoration(
              color: Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: Color.fromRGBO(114, 103, 239, 1)),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
            ),
            new Container(
              margin: new EdgeInsets.only(left: 0.0, top: 4.0),
              child: 
                new Text(
                  icon ?? "Иконка не выбрана",
                  style: TextStyle(color: Color.fromRGBO(114, 103, 239, 1)),

                  ),
            )
          ],
        ),
    ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top:MediaQuery.of(context).size.height/5, bottom: MediaQuery.of(context).size.height/10),
              child: new Form(key: _formKey, child: Column(children: <Widget>[ 
              
                getCustomRadio(icon),
                SizedBox(height: 20,),

              new TextFormField(
                  cursorColor: Color.fromRGBO(114, 103, 239, 1),
                  decoration: InputDecoration(   
                  labelText: 'Название маркера',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),     
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),    
                ),
                validator: (value){
                  if (value.isEmpty) return 'Дайте название своему маркеру';
                  else {
                    _name = value.toString();
                  }
                },
              ),
              SizedBox(height: 10,),
            
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.transparent)
              ),

              onPressed: (){
                if(_formKey.currentState.validate()){
                  if(_name != null){
                    print("Пробую создать");
                    Marker mark = new Marker(
                          name : _name,
                          icon: icon
                        );
                        DBMarkerProvider.db.addMarker(mark).then((res){
                          print(res);
                        }); 
                  }
                }
              },
              color: Color.fromRGBO(114, 103, 239, 1),
              textColor: Colors.white,
              child: 
              Padding(
                child: Text('Создать',
                textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w900, color: Colors.white),),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/3.8,
                  right: MediaQuery.of(context).size.width/3.8,
                  top: MediaQuery.of(context).size.width/25,
                  bottom: MediaQuery.of(context).size.width/25,
                ),
              ),
            ),

            new SizedBox(height: 2.0,),
            FlatButton(
                      onPressed: () {
                          Navigator.pushNamed(context, '/second');
                        },
                        splashColor: Colors.transparent,  
                        highlightColor: Colors.transparent,
                        
                        child: Text(
                          "Назад",
                          style: TextStyle(
                            color:  Color.fromRGBO(114, 103, 239, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            ),
                        ),
                      ),
            ],
          ),
        ),
      ),
  
    );
  }
}