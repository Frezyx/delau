import 'package:delau/blocs/authBloc.dart';
import 'package:delau/pages/auth/login.dart';
import 'package:delau/pages/auth/reg.dart';
import 'package:delau/pages/auth/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: <Widget>[
            Container(
                transform: Matrix4.translationValues(60.0, -60.0, 0.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset('assets/svg/bg-figure.svg'))),
            pages[authPageBloc.pageIndex],
            Container(
                transform: Matrix4.translationValues(-80.0, 80.0, 0.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child:
                        SvgPicture.asset('assets/svg/bg-figure-bottom.svg'))),
          ],
        ),
      ),
    );
  }
}
