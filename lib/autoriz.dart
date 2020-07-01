import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delau/utils/provider/local_store/database_helper.dart';

class AutorizationPage extends StatefulWidget {
  @override
  _AutorizationPageState createState() => _AutorizationPageState();
}

class _AutorizationPageState extends State<AutorizationPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _login;
  String _password;

  Future<String> httploginGet(String link) async {
    var response = await http.get('$link');
    if (response.body.toString().substring(0, 1) == "1") {
      var body = response.body;
      print("Удачно" + body.split(";")[1] + "   " + body.split(";")[2]);
    } else {
      print("Неудачно");
    }
    print(response.body.toString());
    return response.body.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: 40.0,
            right: 40.0,
            top: MediaQuery.of(context).size.height / 5,
            bottom: MediaQuery.of(context).size.height / 10),
        child: new Form(
          key: _formKey,
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 2.0,
                  bottom: 2.0,
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        /*...*/
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Text(
                        "Вход",
                        style: TextStyle(
                          color: Color.fromRGBO(114, 103, 239, 1),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/reg');
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Text(
                        "Регистрация",
                        style: TextStyle(
                          color: Colors.black54,
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
                  labelText: 'Ваш логин или e-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Введите ваш логин';
                  else {
                    _login = value.toString();
                  }
                },
              ),
              new SizedBox(
                height: 10.0,
              ),
              TextFormField(
                cursorColor: Color.fromRGBO(114, 103, 239, 1),
                decoration: InputDecoration(
                  labelText: 'Ваш пароль',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Введите ваш пароль';
                  else {
                    _password = value.toString();
                  }
                },
                obscureText: true,
              ),
              new SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.transparent)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (_login != null && _password != null) {
                      httploginGet(
                              'https://delau.000webhostapp.com/flutter/loginCheckFlutter.php?login=' +
                                  _login +
                                  '&pass=' +
                                  _password)
                          .then((res) {
                        var row = res.split(";");
                        // DBUserProvider.dbc.loginClient(row).then((res){
                        //   Navigator.pushNamed(context, '/user');
                        // });
                      });
                    }
                  }
                },
                color: Color.fromRGBO(114, 103, 239, 1),
                textColor: Colors.white,
                child: Padding(
                  child: Text(
                    'Вход',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontFamily: "Exo 2",
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 3.3,
                    right: MediaQuery.of(context).size.width / 3.3,
                    top: MediaQuery.of(context).size.width / 25,
                    bottom: MediaQuery.of(context).size.width / 25,
                  ),
                ),
              ),
              new SizedBox(
                height: 2.0,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user');
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  "Назад",
                  style: TextStyle(
                    color: Color.fromRGBO(114, 103, 239, 1),
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
