import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:speech_recognition/speech_recognition.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/utils/recognize_helper.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class MyStatefulWidget3 extends StatefulWidget {
  String _id;
  
  MyStatefulWidget3({String id}): _id = id;

  @override
  _MyStatefulWidgetState3 createState() => _MyStatefulWidgetState3();
}

class _MyStatefulWidgetState3 extends State<MyStatefulWidget3> {
  PermissionStatus _status;

  int requestSendFlag = 0;

  //Распознование голоса
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListerning = false;
  String resultText = "";


  final _formKey = GlobalKey<FormState>();
  String _name;
  String _surname;

  String print_time = "Введите время ";
  String print_date = "Введите дату ";

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  int selected_radio;
  double rating = 0.0;

  @override
  void initState(){
    super.initState();
    selected_radio = 0;
    PermissionHandler().checkPermissionStatus(PermissionGroup.speech).then(updateStatus);
        initSpeechRecognizer();
      }
    
      setSelectedRadio(int val){
        setState(() {
          selected_radio = val;
        });
      }
    
      void initSpeechRecognizer(){
        _speechRecognition = SpeechRecognition();
    
        _speechRecognition.setAvailabilityHandler(
          (bool result) {
            setState(() {
            return _isAvailable = result;
          });
          },
          );
    
        _speechRecognition.setRecognitionStartedHandler(
          () => setState(() {
            return _isListerning = true;
          }),
          );
    
        _speechRecognition.setRecognitionResultHandler(
          (String speech) {
            setState(() {
              return resultText = speech;
            });
          },
          );
        
        _speechRecognition.setRecognitionCompleteHandler(
          () {
            setState(() {
              requestSendFlag++;
              // ВОТ ТУТ НУЖНО ДОБАВИТЬ ЕБАНУЮ ДОБАВКУ В БД БЛЯТЬ 
              perseTaskFromResponse(resultText);
              // print("FSQL://title:"+response[0]+"  subtitle:"+response[1]);
              return httpRecognitionRequest("https://delau.000webhostapp.com/flutter/addTaskRecognition.php?request="+resultText);
              // return _isListerning = false;
            });
          },
          
          );
        
        _speechRecognition.activate().then(
          (result) {
            setState((){
              return _isAvailable = result;
            });
          },
          );
      }
    
          httpRecognitionRequest(String link) async{
            if(requestSendFlag == 1){
              var response = await http.get('$link');
              print('${response.body}');
              requestSendFlag = 0;
            }
          return _isListerning = false;
          // return "Обращение было";
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
    
    
        httpGet(String link) async{
        try{
          var response = await http.get('$link');
          print("Статус ответа: ${response.statusCode}");
          print("Тело ответа: ${response.body}");
            if(response.body.toString()!= "0"){
              _badAllert();       
            }
            else{
              _neverSatisfied();
            }
        } catch (error){
          print('Ты ебловоз блять! А вот твоя ошибка: $error');
            return "404";
        }
      }
    
    
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
              padding: EdgeInsets.only(left: 40.0, right: 40.0, top:140,),// color: Colors.transparent,
              child: new Form(key: _formKey, child: new Column(children: <Widget>[
    
            new SizedBox(height: 20.0,),
    
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
    
            new SizedBox(height: 20.0,),
    
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
          new SizedBox(height: 20.0,),
            Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: selected_radio,
                activeColor: Color.fromRGBO(114, 103, 239, 1),
                onChanged: (val){
                  print("$val");
                  setSelectedRadio(val);
                },
              ),
              Text("Учеба"),
              Radio(
                value: 2,
                groupValue: selected_radio,
                activeColor: Color.fromRGBO(114, 103, 239, 1),
                onChanged: (val){
                  print("$val");
                  setSelectedRadio(val);
                },
              ),
              Text("Работа"),
              Radio(
                value: 3,
                groupValue: selected_radio,
                activeColor: Color.fromRGBO(114, 103, 239, 1),
                onChanged: (val){
                  print("$val");
                  setSelectedRadio(val);
                },
              ),
              Text("Cпорт"),
            ]
          ),
          Row(
            children: <Widget>[
              Radio(
                value: 4,
                groupValue: selected_radio,
                activeColor: Color.fromRGBO(114, 103, 239, 1),
                onChanged: (val){
                  print("$val");
                  setSelectedRadio(val);
                },
              ),
              Text("Встерча"),
              Radio(
                value: 5,
                groupValue: selected_radio,
                activeColor: Color.fromRGBO(114, 103, 239, 1),
                onChanged: (val){
                  print("$val");
                  setSelectedRadio(val);
                },
              ),
              Text("Покупки"),
              Radio(
                value: 6,
                groupValue: selected_radio,
                activeColor: Color.fromRGBO(114, 103, 239, 1),
                onChanged: (val){
                  print("$val");
                  setSelectedRadio(val);
                },
              ),
              Text("Другое"),
            ],
          ),
    
            new SizedBox(height: 20.0,),
    
              new Row(
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
                            "$print_date",
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
                            "$print_time",
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
                        marker: selected_radio-1,
                        priority: rating.round(),
                        date: _date.toString(),
                        time: _time.toString(),
                        done: false
                      );

                  addAtLocalDB(now_client);
                  httpGet("https://delau.000webhostapp.com/flutter/addTask.php?header="+_name+"&body="+_surname+"&date="+_date.toString()+"&time="+_time.toString()+"&marker="+(selected_radio-1).toString()+"&paginator="+rating.toString());  
                }
              }
            }, child: Text('Создать'), color: Color.fromRGBO(114, 103, 239, 1), textColor: Colors.white,),
             new RaisedButton(onPressed: (){
                DBProvider.db.deleteAll();
            }, child: Text('Удалить все'), color: Color.fromRGBO(114, 103, 239, 1), textColor: Colors.white,),
            Expanded(
              child:
              Container(
                padding: EdgeInsets.only( left: 0.0, top: 15, bottom: 15, ),
                child: Text(resultText),
              )
            ),
    
          ],
         ),),),
    
                floatingActionButton: FloatingActionButton(
                  heroTag: "btn_num_1_12_234555",
                  onPressed: () {
                          askPermision();
                                                    if(_isAvailable && ! _isListerning)
                                                      {
                                                        // httpGet("https://delau.000webhostapp.com/flutter/addTask.php?header=1&body=1&date=2020-01-15&time=24:13:00&marker=1&paginator=1");
                                                        _speechRecognition.listen(locale: "ru_RU").then((result) => print("aaaaa"));
                                                      }
                                                      // httpRecognitionRequest("https://delau.000webhostapp.com/flutter/addTaskRecognition.php?request="+result),
                                              },
                                            child: Icon(Icons.record_voice_over),
                                            backgroundColor: Color.fromRGBO(114, 103, 239, 1),
                                          ),
                              
                                          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                                                bottomNavigationBar: CurvedNavigationBar(
                                          height: 50.0,
                                          backgroundColor: Colors.transparent,
                                          animationDuration: Duration(microseconds: 2500),
                                          items: <Widget>[
                                            Icon(Icons.list, size: 30, color: Colors.black,),
                                            Icon(Icons.add, size: 30, color: Colors.white,),
                                            Icon(FontAwesome.user_o, size: 30, color: Colors.black,),
                                            // Icon(Icons.compare_arrows, size: 30, color: Colors.black,),
                                            // Icon(Icons.add, size: 30, color: Colors.black,),
                                            // Icon(Icons.list, size: 30, color: Colors.black,),
                                          ],
                                          index: 1,
                                          animationCurve: Curves.bounceInOut,
                                          onTap: (index) {
                                            if(index == 0){
                                              Navigator.pushNamed(context, '/');
                                            }
                                            if(index == 1){
                                              Navigator.pushNamed(context, '/second/1');
                                            }
                                            if(index == 2){
                                              Navigator.pushNamed(context, '/user');
                                            }
                                          },
                                        ),
                                          );
                                }
                                
                                void addAtLocalDB(Client nowClient) async{
                                            await DBProvider.db.newClient(
                                              nowClient
                                            );
                                }
                              
                                void updateStatus(PermissionStatus status) {
                                  if(status != _status){
                                    setState(() {
                                      _status = status;
                                    });
                                  }
                            }
                          
                            void askPermision() {
                              PermissionHandler().requestPermissions([PermissionGroup.speech])
                              .then(onstatusRequest);
                                                          }
                              
                                void onstatusRequest(Map<PermissionGroup, PermissionStatus> statuses) {
                                  final status = statuses[PermissionGroup.speech];
                                  updateStatus(status);
                                }
}