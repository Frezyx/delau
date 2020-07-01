import 'package:delau/widget/appBar/appBar.dart';
import 'package:delau/widget/pages/userPage.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  double screenHeight = 0;
  double screenWidth = 0;
  setImgWH(context) {
    setState(() {
      screenHeight = MediaQuery.of(context).size.height;
      screenWidth = MediaQuery.of(context).size.width;
    });
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10)).then((val) {
      setImgWH(context);
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
        child: Column(
          children: <Widget>[
            getAppBar("", context),
            getPhoto(screenHeight, screenWidth),
          ],
        ),
      ),
    );
  }
}
