import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/utils/recognize_helper.dart';
import 'package:delau/widget/customRadio.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:delau/utils/synchroneHelper.dart';
import 'package:delau/utils/timeHelper.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';

class RadioModel {
  int index;
  bool isSelected;
  final IconData icon;
  final String text;

  RadioModel(this.index, this.isSelected, this.icon, this.text);
}

class MyStatefulWidget3 extends StatefulWidget {
  
  // MyStatefulWidget3({String id}): _id = id;

  @override
  _MyStatefulWidgetState3 createState() => _MyStatefulWidgetState3();
}

class _MyStatefulWidgetState3 extends State<MyStatefulWidget3> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  int requestSendFlag = 0;



  final _formKey = GlobalKey<FormState>();
  List<RadioModel> sampleData = new List<RadioModel>();
  bool registration = false;

  String _name;
  String _surname;

  String print_time = "Введите время ";
  String print_date = "Введите дату ";
  bool print_priority = false;

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  String nToken;

  int selected_radio;
  double rating = 0.0;

  @override
  void initState(){
    super.initState();
    selected_radio = 0;

      sampleData.add(new RadioModel(0, true, FontAwesome.book, 'Учеба'));
      sampleData.add(new RadioModel(1, false, FontAwesome.briefcase, 'Работа'));
      sampleData.add(new RadioModel(2, false, MdiIcons.fromString('basketball'), 'Спорт'));
      sampleData.add(new RadioModel(3, false, FontAwesome.users, 'Встречи'));
      sampleData.add(new RadioModel(4, false, MdiIcons.fromString('shopping'), 'Покупки'));
      sampleData.add(new RadioModel(5, false, FontAwesome.spinner, 'Другое'));
      sampleData.add(new RadioModel(sampleData.length-1, false, Icons.add, 'Ещё'));

    DBMarkerProvider.db.getAllMarks().then((list){
      for(int i = 0; i < list.length; i++){
        sampleData.add(new RadioModel(sampleData.length-1, false, MdiIcons.fromString(list[i].icon), list[i].name));
        print("icon: "+list[i].icon +"     name: "+list[i].name );
      }
      // sampleData.add(new RadioModel(sampleData.length-1, false, Icons.add, 'Добавить'));
    });

    DBUserProvider.dbc.getClientUser(1).then((res){
      registration = (res.reg == 1);
      print(registration);
    });
  }

  setSelectedRadio(int val){
    setState(() {
      selected_radio = val;
      print(val);
    });
  }

  setPriority(){
    setState(() {
      print_priority = true;
    });
  }

    
      Future<void> _selectDate(BuildContext context) async {
        final DateTime picked = await showDatePicker(
          context: context,
          initialDate: _date,
          firstDate: DateTime(2018, 8),
          lastDate: DateTime(2101),
        );
        if (picked != null && picked != _date)
          print('Select Date: ${_date.toString()}' );
          setState(() {
            _date = picked;
            print_date = determinateTextToDate(_date);
          });
      }
    
      Future<void> _selectTime(BuildContext context) async {
        final TimeOfDay picked = await showTimePicker(
          context: context,
          initialTime: _time,
        );
        if (picked != null && picked != _time)
          print('Select Date: ${_time.toString()}' );
          setState(() {
            _time = picked;
            print_time = determinateTextToTime(_time);
            // print_time = _time.toString();
          });
      }

      refreshPriorityPrint(){
        setState(() {
          print_priority = true;
        });
      }

_selectPriority(context){
  return
  showDialog(
    context: context,
    builder: (context) {
      var print_rating = this.rating;
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
                title: Text('Выберете приоритет задачи.', style: TextStyle(fontSize: 20),),
                actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 0.0), 
                        child:
                            StarRating(
                            starConfig:
                              StarConfig(
                                size: 28,
                                strokeColor: Color.fromRGBO(114, 103, 239, 1),
                                fillColor: Color.fromRGBO(114, 103, 239, 1),
                                // emptyColor: Colors.white,
                            ),
                            rating: print_rating / 2,
                            onChangeRating: (int rating) {
                              setState(() {
                                this.rating = rating.toDouble() * 2;
                                print_rating = rating.toDouble() * 2;
                              });
                            },
                          ),
                      ),
                      FlatButton(
                        child: Text('Выбрать'), textColor: Color.fromRGBO(114, 103, 239, 1),
                        onPressed: () {
                          Navigator.of(context).pop();
                          refreshPriorityPrint();
                        },
                      ),
                ]
              );
        },
      );
    },
  );
}

    
        Future<void> _neverSatisfied() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return 
                AlertDialog(
                title: Text('Ваша задача добавлена'),
                // content: SingleChildScrollView(
                //   child: ListBody(
                //     children: <Widget>[
                //       Text('Теперь она появится в таблице с задачами.'),
                //     ],
                //   ),
                // ),
                actions: <Widget>[
                      FlatButton(
                        child: Text('Отменить'), textColor: Color.fromRGBO(114, 103, 239, 1),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
    
                      FlatButton(
                        child: Text('Принять'), textColor: Colors.white, color: Color.fromRGBO(114, 103, 239, 1),
                        onPressed: () {
    
                          Navigator.of(context).pop();
                        },
                      ),
                    ]
              );
            },
          );
        }
    
        Future<void> _badAllert() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return 
                AlertDialog(
                title: Text('Ошибка при создании задачи! Попробуйте ещё раз...'),
                actions: <Widget>[
                      FlatButton(
                        child: Text('Попробовать ещё раз'), textColor: Color.fromRGBO(114, 103, 239, 1),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                ]
              );
            },
          );
        }
    
      httpGetWithAllert(String link) async{
          var response = await http.get('$link');
            if(response.body.toString()!= "1"){
              _badAllert();       
              print("Неудачно        " + response.body.toString());
              print(link);
            }
            else{
              _neverSatisfied();
              print("Удачно        " + response.body.toString());
            }
            print(response.body.toString());
      }
      httpGet(String link) async{
          var response = await http.get('$link');
            if(response.body.toString()!= "1"){      
              print("Неудачно");
            }
            else{
              print("Удачно");
            }
            print(response.body.toString());
      }
    
      @override
      Widget build(BuildContext context) {
         return Scaffold(
          body:
           new Container(
              padding: EdgeInsets.only(top:90,),// color: Colors.transparent,
              child: new Form(key: _formKey, child: new Column(children: <Widget>[



            Padding(
              padding: EdgeInsets.only(left: 40.0, right: 40.0), 
              child:
            new TextFormField(
              cursorColor: Color.fromRGBO(114, 103, 239, 1),
              decoration: InputDecoration(   
              labelText: 'Название задачи',  
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),     
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
              ),    
            ),
              validator: (value){
              if (value.isEmpty) return 'Введите название задания';
              else {
                _name = value.toString();
              }
            },),),
    
            new SizedBox(height: 10.0,),
    
        Padding(
          padding: EdgeInsets.only(left: 40.0, right: 40.0), 
          child:
            TextFormField(
              cursorColor: Color.fromRGBO(114, 103, 239, 1),
              decoration: InputDecoration(        
              labelText: 'Пояснение задачи',  
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),     
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
              ),  
              
              ),
              validator: (value){
              if (value.isEmpty) {
                 _surname = "Вы не выбрали пояснение для задачи";
              }
              else{
                _surname = value.toString();
              }
            },),),

//TODO : заменить на иконочный сборщик с звездами

          new SizedBox(height: 0.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15, bottom: 5), 
            child:
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                    padding: EdgeInsets.only( left: 5.0, right: 5.0, top: 15, bottom: 15, ),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: 
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.date_range,size: 35.0,),
                          Text(
                            "$print_date",
                            style: TextStyle(fontSize: 12.0, fontFamily: 'Roboto', fontWeight: FontWeight.w500,),
                          ),    
                      ],
    
                    ),
                  ),
    
                  FlatButton(
                    color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                    padding: EdgeInsets.only( left: 5.0, top: 15,right: 5.0, bottom: 15),
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: 
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.timer,size: 35.0,),
                        Text(
                            "$print_time",
                            style: TextStyle(fontSize: 12.0, fontFamily: 'Roboto', fontWeight: FontWeight.w500,),
                          ),
                      ],
                    ),
                  ),

                  FlatButton(
                    color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                    padding: EdgeInsets.only( left: 5.0, right: 5.0, top: 15, bottom: 15, ),
                    onPressed: () {
                      _selectPriority(context);
                    },
                    child: 
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.star,size: 35.0,),
                          Text(
                            print_priority ? rating.toString() : "Приоритет",
                            style: TextStyle(fontSize: 12.0, fontFamily: 'Roboto', fontWeight: FontWeight.w500,),
                          ),    
                      ],
    
                    ),
                  ),

                ]
              ),
            ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
          height: 100.0,
          child:
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sampleData.length,
              itemBuilder: (context, i) {
                return 
                InkWell(
                onTap: () {
                  if(i == 7){
                    sampleData.removeAt(sampleData.length-1);
                    Navigator.pushNamed(context, '/addMark');
                  }
                  setSelectedRadio(i+1);
                  setState(() {
                    sampleData.forEach((element) => element.isSelected = false);
                    sampleData[i].isSelected = true;
                  });
                },
                splashColor: Color.fromRGBO(114, 103, 239, 1),
                child: getCustomRadio(sampleData[i], sampleData.length),
                );
              }
            ),
          ),
    

            // new SizedBox(height: 10.0,),
            new RaisedButton(onPressed: (){
              if(_formKey.currentState.validate()){
                if(_name != null && _surname != null){

              if(selected_radio <= 7){
                  Client now_client = new Client(
                        title: _name,
                        description: _surname,
                        marker: selected_radio == 0 ? 0 : selected_radio - 1,
                        icon:  "none",
                        priority: rating.round(),
                        date: _date.toString(),
                        time: _time.toString(),
                        deleted: 0,
                        passed: 1,
                        done: false
                      );

                  DBProvider.db.newClient(now_client).then((id){
                        check().then((intenet) {
                          if (intenet != null && intenet && registration) {
                            DBUserProvider.dbc.getUserId().then((userIdServer){
                              httpGetWithAllert("https://delau.000webhostapp.com/flutter/addTask.php?header="+
                              _name+"&body="+_surname+"&date="+_date.toString()+"&time="+
                              _time.toString()+"&marker="+(selected_radio).toString()+"&paginator="+
                              rating.round().toString()+"&user_id="+userIdServer.toString()+
                              "&fromMobile=1&mobile_id="+id.toString());
                            });
                            // Internet Present Case
                          }
                          // No-Internet Case
                        });
                  });
                }
                else{
                  DBMarkerProvider.db.getMarkById(selected_radio-8).then((iconData){
                  Client now_client = new Client(
                        title: _name,
                        description: _surname,
                        marker: selected_radio == 0 ? 0 : selected_radio - 1,
                        icon:  iconData,
                        priority: rating.round(),
                        date: _date.toString(),
                        time: _time.toString(),
                        deleted: 0,
                        passed: 1,
                        done: false
                      );

                  DBProvider.db.newClient(now_client).then((id){
                        check().then((intenet) {
                          if (intenet != null && intenet && registration) {
                            DBUserProvider.dbc.getUserId().then((userIdServer){
                              httpGetWithAllert("https://delau.000webhostapp.com/flutter/addTask.php?header="+
                              _name+"&body="+_surname+"&date="+_date.toString()+"&time="+
                              _time.toString()+"&marker="+(selected_radio).toString()+"&paginator="+
                              rating.round().toString()+"&user_id="+userIdServer.toString()+
                              "&fromMobile=1&mobile_id="+id.toString());
                            });
                            // Internet Present Case
                          }
                          // No-Internet Case
                        });
                  });
                });
              }

                  counter();
                  _firebaseMessaging.getToken().then((token){
                    httpGet("https://delau.000webhostapp.com/flutter/addNotif.php?token="+token+"&date="+_date.toString()+"&time="+_time.toString());
                  });

                  // // var link = "https://delau.000webhostapp.com/flutter/addNotif.php?token="+nToken+"&date="+_date.toString()+"&time="+_time.toString();

                  // _firebaseMessaging.getToken().then((token){
                  //   httpGet("https://delau.000webhostapp.com/flutter/addNotif.php?token="+token+"&date="+_date.toString()+"&time="+_time.toString());
                  //   // print("https://delau.000webhostapp.com/flutter/addNotif.php?token="+token+"&date="+_date.toString()+"&time="+_time.toString());
                  // });
                  // // print(link);
                }
              }
            }, child: Text('Создать'), color: Color.fromRGBO(114, 103, 239, 1), textColor: Colors.white,),
            //  new RaisedButton(onPressed: (){
            //     DBProvider.db.deleteAll();
            // }, child: Text('Удалить все'), color: Color.fromRGBO(114, 103, 239, 1), textColor: Colors.white,),
    
          ],
         ),),),
                              
                                          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                                                bottomNavigationBar: CurvedNavigationBar(
                                          height: 50.0,
                                          backgroundColor: Colors.transparent,
                                          animationDuration: Duration(microseconds: 2500),
                                          items: <Widget>[
                                            Icon(Icons.list, size: 30, color: Colors.black54,),
                                            Icon(FontAwesome.sticky_note_o, size: 30, color: Colors.black54,),
                                            Icon(Icons.add, size: 30, color: Colors.deepPurpleAccent,),
                                            Icon(Icons.pie_chart_outlined, size: 30, color: Colors.black54,),
                                            Icon(FontAwesome.user_o, size: 30, color: Colors.black54,),
                                            // Icon(Icons.compare_arrows, size: 30, color: Colors.black,),
                                            // Icon(Icons.add, size: 30, color: Colors.black,),
                                            // Icon(Icons.list, size: 30, color: Colors.black,),
                                          ],
                                          index: 2,
                                          animationCurve: Curves.bounceInOut,
                                          onTap: (index) {
                                            if(index == 0){
                                              Navigator.pushNamed(context, '/');
                                            }
                                            if(index == 1){
                                              Navigator.pushNamed(context, '/notes');
                                            }
                                            if(index == 2){
                                              Navigator.pushNamed(context, '/second');
                                            }
                                            if(index == 3){
                                              Navigator.pushNamed(context, '/rating');
                                            }
                                            if(index == 4){
                                              Navigator.pushNamed(context, '/user');
                                            }
                                          },
                                        ),
                                          );
                                }
                                
                                Future<int> addAtLocalDB(Client nowClient) async{
                                            DBProvider.db.newClient(nowClient).then((id){
                                              return id;
                                            });
                                }

                                void counter() async{
                                            await DBUserProvider.dbc.updateCount( );
                                }
      getIcon(int i){
        IconData iconData;
        print((i-7).toString() + " Чет говно");
        DBMarkerProvider.db.getMarkById(i-7).then((icon){
           iconData = MdiIcons.fromString('$icon');
        });
        return iconData;
    }
                              
}
