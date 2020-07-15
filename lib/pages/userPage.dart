import 'package:delau/blocs/userPageBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/pages/userEditPage.dart';
import 'package:delau/widget/alerts/alertManager.dart';
import 'package:delau/widget/appBar/appBar.dart';
import 'package:delau/widget/pages/userPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final userPageBloc = Provider.of<UserPageBloc>(context);
    userPageBloc.loadUserData();
    userPageBloc.loadUserParamsData();

    Future.delayed(const Duration(milliseconds: 10)).then((val) {
      setImgWH(context);
    });
    return !userPageBloc.isLoad
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : userPageBloc.pageIndex == 1
            ? UserEditPage()
            : Scaffold(
                body: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                  child: Column(children: <Widget>[
                    getUserAppBar("Пофиль", context),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        children: <Widget>[
                          getPhoto(screenHeight, screenWidth, Container()),
                          SizedBox(height: 30),
                          Text(
                              userPageBloc.user.name +
                                  " " +
                                  userPageBloc.user.surname,
                              style: DesignTheme.userPageName),
                          SizedBox(height: 5),
                          Text(userPageBloc.user.email,
                              style: DesignTheme.userPageEmail),
                          SizedBox(height: 30),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                getInfoCard(
                                    context,
                                    userPageBloc.userParams.countDay,
                                    "Задач сегодня"),
                                getInfoCard(
                                    context,
                                    userPageBloc.userParams.countAll,
                                    "Задач создано"),
                                getInfoCard(
                                    context,
                                    userPageBloc.userParams.countDone,
                                    "Задач выполнено"),
                              ]),
                          SizedBox(height: 50),
                          // buildNotifyField("Email", userPageBloc.user.email),
                          // SizedBox(height: 30),
                          userPageBloc.user.isTelegramAuth
                              ? buildNotifyFieldEdit("Telegram", userPageBloc)
                              : buildNotifyField("Telegram", userPageBloc),
                          SizedBox(height: 50),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth / 5,
                                    right: screenWidth / 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                      boxShadow: DesignTheme
                                          .buttons.selectedTabHomeShadow),
                                  child: RaisedButton(
                                    elevation: 0,
                                    color: DesignTheme.mainColor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.edit, color: Colors.white),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text("Редактировать",
                                              style: DesignTheme
                                                  .buttons.selectedTabText),
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
                              SizedBox(height: 5),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth / 5,
                                    right: screenWidth / 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                      boxShadow:
                                          DesignTheme.buttons.tabHomeShadow),
                                  child: RaisedButton(
                                    elevation: 0,
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        DesignTheme.icons.closeIcon,
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text("Выйти",
                                              style: DesignTheme
                                                  .buttons.selectedTabText),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      AlertManager.getLogoutAlert(context);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              );
  }
}
