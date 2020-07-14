import 'package:delau/blocs/authBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SatrtAuthPage extends StatefulWidget {
  @override
  _SatrtAuthPageState createState() => _SatrtAuthPageState();
}

class _SatrtAuthPageState extends State<SatrtAuthPage>
    with SingleTickerProviderStateMixin {
  var height;
  var width;
  AnimationController _animationController;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 5000), vsync: this)
          ..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.06))
        .animate(
            CurvedAnimation(curve: Curves.ease, parent: _animationController));
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    final authPageBloc = Provider.of<AuthPageBloc>(context);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(left: width / 15, right: width / 15, top: 30),
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
                                    child: Image.asset("assets/img/logo.jpg"),
                                  ),
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(10.0, 0.0, 0.0),
                                  child: Text(
                                      "Хватит откладывать на потом! Структурируй свои задачи, настрой уведомления и вперед к цели !",
                                      style: DesignTheme.authText),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ])),
            ),
            SlideTransition(
              child: Container(
                  transform: Matrix4.translationValues(38.0, 0.0, 0.0),
                  width: width * 0.95,
                  height: width * 0.9,
                  child: SvgPicture.asset('assets/svg/auth.svg')),
              position: _offsetAnimation,
            ),
            Padding(
              padding: EdgeInsets.only(left: width / 4, right: width / 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: DesignTheme.buttons.selectedTabHomeShadow),
                      child: RaisedButton(
                        elevation: 0,
                        color: DesignTheme.mainColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text("Вход",
                                  style: DesignTheme.buttons.mainButtonText),
                            ),
                          ],
                        ),
                        onPressed: () {
                          authPageBloc.pageIndex = 1;
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
                          side: BorderSide(color: DesignTheme.mainColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text("Регистрация",
                                style: DesignTheme.buttons.secondaryButtonText),
                          ),
                        ],
                      ),
                      onPressed: () {
                        authPageBloc.pageIndex = 2;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
