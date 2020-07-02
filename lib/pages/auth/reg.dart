import 'package:delau/blocs/authBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/models/user.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'package:delau/widget/snackBar/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var height;
  var width;
  final _formKey = GlobalKey<FormState>();
  User user = User();
  @override
  Widget build(BuildContext context) {
    final authPageBloc = Provider.of<AuthPageBloc>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(
            builder: (context) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: width / 10, right: width / 10, top: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Регистрация",
                                    style: DesignTheme.bigBlueText),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                onTap: () {},
                                cursorColor: DesignTheme.mainColor,
                                decoration: InputDecoration(
                                    labelText: 'Имя',
                                    labelStyle: DesignTheme.textFieldLabel,
                                    suffixIcon: Icon(
                                      Icons.people_outline,
                                    )),
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Введите ваше имя';
                                  else {
                                    user.name = value.toString();
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                onTap: () {},
                                cursorColor: DesignTheme.mainColor,
                                decoration: InputDecoration(
                                    labelText: 'Фамилия',
                                    labelStyle: DesignTheme.textFieldLabel,
                                    suffixIcon: Icon(
                                      Icons.people_outline,
                                    )),
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Введите вашу фамилию';
                                  else {
                                    user.surname = value.toString();
                                  }
                                },
                              ),
                              TextFormField(
                                onTap: () {},
                                cursorColor: DesignTheme.mainColor,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: DesignTheme.textFieldLabel,
                                    suffixIcon: Icon(
                                      Icons.alternate_email,
                                    )),
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Введите ваш email';
                                  else {
                                    user.email = value.toString();
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                onTap: () {},
                                obscureText: authPageBloc.passwordCover,
                                cursorColor: DesignTheme.mainColor,
                                decoration: InputDecoration(
                                  labelText: 'Пароль',
                                  labelStyle: DesignTheme.textFieldLabel,
                                  suffixIcon: IconButton(
                                    icon: Icon(authPageBloc.passwordCover
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye),
                                    onPressed: () {
                                      authPageBloc.setPasswordCover();
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Введите ваш пароль';
                                  else {
                                    user.password = value.toString();
                                  }
                                },
                              ),
                            ]),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width / 4, right: width / 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: DesignTheme
                                      .buttons.selectedTabHomeShadow),
                              child: RaisedButton(
                                elevation: 0,
                                color: DesignTheme.mainColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Продолжить",
                                        style:
                                            DesignTheme.buttons.mainButtonText),
                                  ],
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    API.userHandler
                                        .createUser(user)
                                        .then((res) {
                                      if (res) {
                                        API.userHandler
                                            .authUser(user)
                                            .then((res) {
                                          if (res) {
                                            Navigator.pushNamed(context, "/");
                                          } else {
                                            Scaffold.of(context).showSnackBar(
                                                SnackBarCustom.badRegSnackBar);
                                          }
                                        });
                                      } else {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBarCustom.badRegSnackBar);
                                      }
                                    });
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: RaisedButton(
                              elevation: 0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side:
                                      BorderSide(color: DesignTheme.mainColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Вход",
                                      style: DesignTheme
                                          .buttons.secondaryButtonText),
                                ],
                              ),
                              onPressed: () {
                                authPageBloc.pageIndex = 1;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )));
  }
}
