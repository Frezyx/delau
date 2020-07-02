import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var height;
  var width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/bg.jpg"), fit: BoxFit.cover)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: width / 15, right: width / 15, top: 30),
                      child: Container(
                          width: width - (width / 15 * 2),
                          child: Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: width / 1.4,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: height / 10),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 8.0, right: width / 3),
                                          child: Container(
                                            transform:
                                                Matrix4.translationValues(
                                                    0.0, 0.0, 0.0),
                                            child: Image.asset(
                                                "assets/img/logo.jpg"),
                                          ),
                                        ),
                                        Text(
                                            "Хватит откладывать на потом! Структурируй свои задачи, настрой уведомления и вперед к цели !",
                                            style: DesignTheme.authText),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ])),
                    ),
                    Container(
                        transform: Matrix4.translationValues(30.0, 0.0, 0.0),
                        width: width * 0.95,
                        height: width * 0.9,
                        child: SvgPicture.asset('assets/svg/auth.svg')),
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
                                    // Icon(Icons.save, color: Colors.white),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text("Вход",
                                          style: DesignTheme
                                              .buttons.mainButtonText),
                                    ),
                                  ],
                                ),
                                onPressed: () {},
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
                                  // Icon(Icons.save,
                                  //     color: DesignTheme.mainColor),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text("Регистрация",
                                        style: DesignTheme
                                            .buttons.secondaryButtonText),
                                  ),
                                ],
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
