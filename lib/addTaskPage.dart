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
            // print_date = _date.toString();
            print_date = "Выбрана дата";
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
            print_time = "Выбрано вр";
            // print_time = _time.toString();
          });
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
      //   httpGet(String link) async{
      //   try{
      //     var response = await http.get('$link');
      //     print("Статус ответа: ${response.statusCode}");
      //     print("Тело ответа: ${response.body}");
      //       if(response.body.toString()!= "0"){
      //         _badAllert();       
      //       }
      //       else{
      //         _neverSatisfied();
      //       }
      //   } catch (error){
      //     print('Ты ебловоз блять! А вот твоя ошибка: $error');
      //       return "404";
      //   }
      // }
    
    
      @override
      Widget build(BuildContext context) {
         return Scaffold(
          // appBar: AppBar(
          //         // backgroundColor: Color.fromRGBO(76, 175, 80, 100),
          //         backgroundColor: Color.fromRGBO(114, 103, 239, 1),
          //         title: const Text('DELAU'),
          //     ),
          body:
           new Container(
              padding: EdgeInsets.only(left: 40.0, right: 40.0, top:90,),// color: Colors.transparent,
              child: new Form(key: _formKey, child: new Column(children: <Widget>[
    
            
    
            // new Text('Название', style: TextStyle(fontSize: 20.0)),
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
            },),
    
            new SizedBox(height: 10.0,),
    
            // new Text('Приоритет', style: TextStyle(fontSize: 20.0)),
            // new TextFormField(
            //   cursorColor: Color.fromRGBO(114, 103, 239, 1),
            //   decoration: InputDecoration(        
            //   focusedBorder: UnderlineInputBorder(      
            //     borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),   
            //   ),    
            // ),
            //   validator: (value){
            //   if (value.isEmpty) return 'Выберете приоритет';
            //   // else
            // },),
    
            // new Text('Пояснение', style: TextStyle(fontSize: 20.0)),
            new TextFormField(
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
              if (value.isEmpty) return 'Введите пояснение для задания';
              else{
                _surname = value.toString();
              }
            },),
    
            // new SizedBox(height: 20.0,),
          //   Text("Маркер задачи",
          // style: TextStyle(
          //   fontSize: 18.0,
          //   fontFamily: 'Exo 2',
          //   fontWeight: FontWeight.w300,
          //   // color: Color.fromRGBO(114, 103, 239, 1),
          //   ),     
          // ),
        // new SizedBox(height: 20.0,),

        // ListView.builder(
        //   itemCount: 4,
        //   itemBuilder: (context, i) {
        //     return ListTile(
                  
        //         );
        //   },
        // ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
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

          new SizedBox(height: 0.0),
              new Column(
                children: <Widget>[
                  FlatButton(
                    color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                    padding: EdgeInsets.only( left: 15.0, right: 15.0, top: 15, bottom: 15, ),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: 
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.date_range,size: 20.0,),
                          Text(
                            "$_date",
                            style: TextStyle(fontSize: 15.0, fontFamily: 'Roboto', fontWeight: FontWeight.w500,),
                          ),    
                      ],
    
                    ),
                  ),
    
                  FlatButton(
                    color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                    padding: EdgeInsets.only( left: 15.0, top: 15,right: 15.0, bottom: 15),
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: 
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.timer,size: 20.0,),
                        Text(
                            "$_time",
                            style: TextStyle(fontSize: 15.0, fontFamily: 'Roboto', fontWeight: FontWeight.w500,),
                          ),
                      ],
                    ),
                  ),
                ]
                ),
    
            new SizedBox(height: 20.0,),
    
          // new SizedBox(height: 15.0,),
          Text("Важность задачи",
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Exo 2',
            fontWeight: FontWeight.w300,
            ),     
          ),
    
          Slider(
            value: rating,
            onChanged: (double newRating) {
              setState(()=> rating = newRating);
            },
            min: 0.0,
            max: 10.0,
            divisions: 10,
            label: "$rating",
            activeColor: Color.fromRGBO(114, 103, 239, 1),
            inactiveColor: Colors.black12,
          ),
            new SizedBox(height: 10.0,),
            new RaisedButton(onPressed: (){
              if(_formKey.currentState.validate()){
                if(_name != null && _surname != null){
    
                  Client now_client = new Client(
                        title: _name,
                        description: _surname,
                        marker: selected_radio,
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
    
                // floatingActionButton: FloatingActionButton(
                //   heroTag: "btn_num_1_12_234555",
                //   onPressed: () {
                //           askPermision();
                //             if(_isAvailable && ! _isListerning)
                //             {
                //               _speechRecognition.listen(locale: "ru_RU").then((result) => print("aaaaa"));
                //             }
                //           },
                                          //   child: Icon(Icons.record_voice_over),
                                          //   backgroundColor: Color.fromRGBO(114, 103, 239, 1),
                                          // ),
                              
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
                              
}
