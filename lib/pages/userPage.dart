import 'package:delau/design/theme.dart';
import 'package:delau/widget/appBar/appBar.dart';
import 'package:delau/widget/pages/userPage.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  double screenHeight = 50;
  double screenWidth = 50;
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
            SizedBox(height: 20),
            getPhoto(screenHeight, screenWidth),
            SizedBox(height: 30),
            Text("Юрий Дудь", style: DesignTheme.userPageName),
            SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  getInfoCard(context),
                  getInfoCard(context),
                  getInfoCard(context),
                ]),
            SizedBox(height: 50),
            buildNotifyField(),
            SizedBox(height: 30),
            buildNotifyField(),
          ],
        ),
      ),
    );
  }
}
