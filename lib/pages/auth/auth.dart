import 'package:delau/blocs/authBloc.dart';
import 'package:delau/pages/auth/login.dart';
import 'package:delau/pages/auth/reg.dart';
import 'package:delau/pages/auth/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var pages = [SatrtAuthPage(), LoginPage(), RegistrationPage()];
  @override
  Widget build(BuildContext context) {
    final authPageBloc = Provider.of<AuthPageBloc>(context);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/bg.jpg"), fit: BoxFit.cover)),
          child: pages[authPageBloc.pageIndex],
        ));
  }
}
