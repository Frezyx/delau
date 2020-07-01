import 'package:delau/blocs/userPageBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/pages/userEditPage.dart';
import 'package:delau/widget/appBar/appBar.dart';
import 'package:delau/widget/pages/userPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var userPageBloc;
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
    userPageBloc = Provider.of<UserPageBloc>(context);
    Future.delayed(const Duration(milliseconds: 10)).then((val) {
      setImgWH(context);
    });
    return userPageBloc.pageIndex == 1
        ? UserEditPage()
        : Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  getAppBar("Пофиль", context),
                  SizedBox(height: 20),
                  getPhoto(screenHeight, screenWidth, Container()),
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
                  buildNotifyField("Email", "dudu@gmail.com"),
                  SizedBox(height: 30),
                  buildNotifyField("Telegram", "@duduri"),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth / 5, right: screenWidth / 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(30.0),
                          boxShadow: DesignTheme.buttons.selectedTabHomeShadow),
                      child: RaisedButton(
                        elevation: 0,
                        color: DesignTheme.mainColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.edit, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text("Редактировать",
                                  style: DesignTheme.buttons.selectedTabText),
                            ),
                          ],
                        ),
                        onPressed: () {
                          userPageBloc.pageIndex = 1;
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
