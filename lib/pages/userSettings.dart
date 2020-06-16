import 'dart:convert';

import 'package:delau/main.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/utils/synchroneHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserModel {
  final int id;
  final String name;
  final String surname;
  final String login;
  final String email;
  final String password;
 
  UserModel({ this.id, this.name, this.surname,
   this.login, this.email, this.password });
 
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json['id']),
      name: json['name'] as String,
      surname: json['surname'] as String,
      login: json['login'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
}

List<UserModel> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
 
  return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
}

Future<List<UserModel>> fetchPosts(http.Client client, int id) async {
  final response = await client.get('https://delau.000webhostapp.com/flutter/getUserById.php?id='+id.toString());
  print("Запрос с id --> "+id.toString()+" Вернул -->"+ response.body);
  return parsePosts(response.body);
}





class UpdatePage extends StatefulWidget {
  UpdatePage({ Key key, this.title}): super(key: key);
 final String title;
 @override
 _UpdatePageState createState()  => new _UpdatePageState( );
}
class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  int userId;
  final TextEditingController _nameController = new TextEditingController( );
  final TextEditingController _surnameController = new TextEditingController( );
  final TextEditingController _loginController = new TextEditingController( );
  final TextEditingController _emailController = new TextEditingController( );

    @override
    void initState(){
      super.initState();
      DBUserProvider.dbc.getUserId().then((idUser){
        fetchPosts(http.Client(), idUser).then((user){
          _nameController.text = user[0].name;
          _surnameController.text = user[0].surname;
          _loginController.text = user[0].login;
          _emailController.text = user[0].email;
        });
        userId = idUser;
      });
    }

            Future<void> _allert() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return 
                AlertDialog(
                title: Text('Задачи, добавленные в дальнейшем будут удалены при следующем входе. Продолжить?'),
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
    
                          exitUser();
                          Navigator.pushNamed(context, '/user');
                        },
                      ),
                    ]
              );
            },
          );
        }

 @override
 build(BuildContext context) {

        httpGet(String link) async{
          var response = await http.get('$link');
            if(response.body.toString() == "1"){
              print("Удачно");
            }
            else{     
              print("Неудачно");
            }
            print(response.body.toString());
      }

 return new Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top:90,),
        child: new Form(key: _formKey, child: new Column(children: <Widget>[ 

              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Имя",
                  suffixIcon: CircleIconButton(
                    onPressed: () {
                      this.setState(() {
                        _nameController.clear();
                      });
                    },
                  )
                ),
              ),

              new SizedBox(height: 5.0,),

              TextField(
                controller: _surnameController,
                decoration: InputDecoration(
                  hintText: "Фамилия",
                  suffixIcon: CircleIconButton(
                    onPressed: () {
                      this.setState(() {
                        _surnameController.clear();
                      });
                    },
                  )
                ),
              ),

              new SizedBox(height: 5.0,),
               
              TextField(
                controller: _loginController,
                decoration: InputDecoration(
                  hintText: "Логин",
                  suffixIcon: CircleIconButton(
                    onPressed: () {
                      this.setState(() {
                        _loginController.clear();
                      });
                    },
                  )
                ),
              ),

              new SizedBox(height: 5.0,),

              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "E-mail",
                  suffixIcon: CircleIconButton(
                    onPressed: () {
                      this.setState(() {
                        _emailController.clear();
                      });
                    },
                  )
                ),
              ),

              new SizedBox(height: 15.0,),

              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.transparent)
                ),

                onPressed: (){
                        check().then((intenet) {
                          if (intenet != null && intenet) {
                            print("connected");
                            httpGet("https://delau.000webhostapp.com/flutter/updateUser.php?name="+
                            _nameController.text+"&surname="+_surnameController.text+"&email="+_emailController.text+
                            "&login="+_loginController.text+"&userIdServer="+userId.toString()).then((res){

                              updateAtLocalDB(_nameController.text, _surnameController.text, _emailController.text, _loginController.text, userId);
                            });
                          }
                        });
                },
              color: Color.fromRGBO(114, 103, 239, 1),
              textColor: Colors.white,
              
              
              child: 
              Padding(
                child: Text('Сохранить изменения',
                textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w900, color: Colors.white),),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/8.6,
                  right: MediaQuery.of(context).size.width/8.6,
                  top: MediaQuery.of(context).size.width/25,
                  bottom: MediaQuery.of(context).size.width/25,
                  ),
                ),
              ),

              new SizedBox(height: 10.0,),

              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: Color.fromRGBO(114, 103, 239, 1))
                ),
                highlightColor : Colors.white,
                splashColor:  Color.fromRGBO(114, 103, 239, 1),
                onPressed: (){},
                color: Colors.white,
                textColor: Color.fromRGBO(114, 103, 239, 1),
                elevation: 0.0,
                child: 
                Padding(
                  child: Text('Изменить пароль',
                  textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w900, color: Color.fromRGBO(114, 103, 239, 1),),),
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width/6.1,
                    right: MediaQuery.of(context).size.width/6.1,
                    top: MediaQuery.of(context).size.width/25,
                    bottom: MediaQuery.of(context).size.width/25,
                    ),
                  ),
                ),

              new SizedBox(height: 10.0,),

              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: Color.fromRGBO(114, 103, 239, 1))
                ),
                highlightColor : Colors.white,
                splashColor:  Color.fromRGBO(114, 103, 239, 1),
                onPressed: (){
                  print("exit with id = " + userId.toString());
                  _allert();
                },
                color: Colors.white,
                textColor: Color.fromRGBO(114, 103, 239, 1),
                elevation: 0.0,
                child: 
                Padding(
                  child: Text('Выйти',
                  textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w900, color: Color.fromRGBO(114, 103, 239, 1),),),
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width/3.6,
                    right: MediaQuery.of(context).size.width/3.6,
                    top: MediaQuery.of(context).size.width/25,
                    bottom: MediaQuery.of(context).size.width/25,
                    ),
                  ),
                ),
                new SizedBox(height: 200.0,),

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

  void updateAtLocalDB(String name, String surname, String email, String login, int userId) async{
      print("try to add user with Server id = " + userId.toString());
      updateLocal(name, surname, email, login, userId);
  }

  void updateLocal(name, surname, email, login, userId) async{
        await DBUserProvider.dbc.updateClient(
      name , surname, email, login, userId
    );
  }

  void exitUser() async{
        await DBUserProvider.dbc.exitClient();
  }

class CircleIconButton extends StatelessWidget {
  final double size;
  final Function onPressed;
  final IconData icon;
  CircleIconButton({ this.size = 30.0, this.icon = Icons.clear, this.onPressed});

  @override
  build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: SizedBox(
      width: size,
      height: size,
      child: Stack(
      alignment: Alignment( 0.0, 0.0 ),
      children: <Widget>[
                      Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
      shape: BoxShape.circle, color: Colors.transparent ),),
            Icon(
              icon,
              size: size * 0.6,
              color: Colors.deepPurpleAccent,
              )
        ],
      )));
  }
}