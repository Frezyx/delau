import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/utils/synchroneHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String testDevice = 'C6293A6928D85AF1';


class RegistrationPage extends StatefulWidget{
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _login;
  String _password;
  int _countDone;
  int _countAdd;
  int _rating;

  @override
    void initState(){

      super.initState();
      DBUserProvider.dbc.getClientUser(1).then((res){
        _countDone = res.countDone;
        _countAdd = res.countAdd;
        _rating = res.rating;
      });
    }

  Future<String> httpGet(String link) async{
          var response = await http.get('$link');
            if(response.body.toString().substring(0,1)== "1"){
              _neverSatisfied();
              print("Удачно");
            }
            else if(response.body.toString().substring(0,1)== "3"){
              _loginNotFree();
              print("Удачно");
            }
            else{
              _badAllert();       
              print("Неудачно"+response.body);
            }
            print(response.body.toString());
            return response.body.toString();
      }

          Future<void> _neverSatisfied() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return 
                AlertDialog(
                title: Text('Ваш аккаунт создан'),
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
    
                          Navigator.pushNamed(context, '/user');
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
            barrierDismissible: false,
            builder: (BuildContext context) {
              return 
                AlertDialog(
                title: Text('Ошибка при создании аккаунта! Попробуйте ещё раз...'),
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

        Future<void> _loginNotFree() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, 
            builder: (BuildContext context) {
              return 
                AlertDialog(
                title: Text('Данный логин занят! Выбирите другой'),
                actions: <Widget>[
                      FlatButton(
                        child: Text('Принять'), textColor: Color.fromRGBO(114, 103, 239, 1),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                ]
              );
            },
          );
        }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top:MediaQuery.of(context).size.height/5, bottom: MediaQuery.of(context).size.height/10),
              child: new Form(key: _formKey, child: new Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only( left :MediaQuery.of(context).size.width/30, right :MediaQuery.of(context).size.width/30,),
              child:                 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,   

                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                          Navigator.pushNamed(context, '/autoriz');
                        },
                        splashColor: Colors.transparent,  
                        highlightColor: Colors.transparent,

                        child: Text(
                          "Вход",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                          ),
                          
                        ),
                      ),
                    FlatButton(
                      onPressed: () {
                        },
                        splashColor: Colors.transparent,  
                        highlightColor: Colors.transparent,

                        child: Text(
                          "Регистрация",
                          style: TextStyle(
                            color: Color.fromRGBO(114, 103, 239, 1),
                            fontSize: 18.0,
                            ),
                        ),
                      ),
                  ],  
                ),
              ),

                new TextFormField(
                  cursorColor: Color.fromRGBO(114, 103, 239, 1),
                  decoration: InputDecoration(   
                  labelText: 'Ваше имя и фамилия',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),     
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),    
                ),
                validator: (value){
                  if (value.isEmpty) return 'Введите ваше имя и фамилию';
                  else {
                    _name = value.toString();
                  }
                },
              ),

              new SizedBox(height: 10.0,),

              new TextFormField(
                  cursorColor: Color.fromRGBO(114, 103, 239, 1),
                  decoration: InputDecoration(   
                  labelText: 'Ваш e-mail',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),     
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),    
                ),
                validator: (value){
                  if (value.isEmpty) return 'Введите ваш e-mail';
                  else {
                    _email = value.toString();
                  }
                },
              ),
              new SizedBox(height: 10.0,),

              new TextFormField(
                  cursorColor: Color.fromRGBO(114, 103, 239, 1),
                  decoration: InputDecoration(   
                  labelText: 'Ваш логин',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),     
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),    
                ),
                validator: (value){
                  if (value.isEmpty) return 'Введите ваш логин';
                  else {
                    _login = value.toString();
                  }
                },
              ),
              new SizedBox(height: 10.0,),

               TextFormField(
                  cursorColor: Color.fromRGBO(114, 103, 239, 1),
                  decoration: InputDecoration(   
                  labelText: 'Ваш пароль',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    
                  ),     
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),    
                ),
                validator: (value){
                  if (value.isEmpty) return 'Введите ваш пароль';
                  else {
                    _password = value.toString();
                  }
                },
                obscureText: true,
              ),
              new SizedBox(height: 20.0,),

            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.transparent)
              ),

              onPressed: (){
                if(_formKey.currentState.validate()){
                  if(_name != null && _email != null && _login != null && _password != null){
                      var surAndName = _name.split(" ");
                      ClientUser now_client;
                      if (surAndName.length == 2){
                        now_client = new ClientUser(
                          name: surAndName[0],
                          surname: surAndName[1],
                        );
                      }
                      else{
                        now_client = new ClientUser(
                          name: _name,
                          surname: " ",
                        );
                      }
                    check().then((intenet) {
                          if (intenet != null && intenet) {
                            print("connected");
                            httpGet("https://delau.000webhostapp.com/flutter/addUser.php?name="+
                            surAndName[0]+"&surname="+surAndName[1]+"&email="+_email+
                            "&login="+_login+"&pass="+_password+"&countAdd="+_countAdd.toString()+
                            "&countDone="+_countDone.toString()+"&rating="+_rating.toString()).then((res){
                              if(res.length > 1){
                                var addId = int.parse(res.split(";")[1]);
                                print("Получил Id: "+addId.toString()+"  from DB");
                                registrationAtLocalDB(now_client, addId);
                                synchronize(addId);
                              }
                            });
                          }
                        });
                  }  
                }
              },
              color: Color.fromRGBO(114, 103, 239, 1),
              textColor: Colors.white,
              
              
              child: 
              Padding(
                child: Text('Зарегистрироваться',
                textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w900, color: Colors.white),),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/7.7,
                  right: MediaQuery.of(context).size.width/7.7,
                  top: MediaQuery.of(context).size.width/25,
                  bottom: MediaQuery.of(context).size.width/25,
                ),
              ),
            ),
            
            new SizedBox(height: 2.0,),
            FlatButton(
                      onPressed: () {
                          Navigator.pushNamed(context, '/user');
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
      
  void registrationAtLocalDB(ClientUser nowClient, int userId) async{
      print("try to add user with Server id = " + userId.toString());
      regLocal(nowClient, userId);
  }

  void regLocal(nowClient, userId) async{
        await DBUserProvider.dbc.registrationClient(
      nowClient.name , nowClient.surname, userId
    );
  }

  httpGetLastId(String link) async{
          var response = await http.get('$link');
          print(response.body.toString());
          return response.body.toString();
      }

  void synchronize(addId){
    runSync(addId);
  }
