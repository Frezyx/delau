import 'dart:async';
import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;

import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:delau/widget/noRegister.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  Timer _timer;
  int _start = 12;
  bool killPreload = false;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

// var countTask =  DBProvider.db.getContNow();
  bool registration = false;
  int userId = 0;

  @override
  void initState() {
    super.initState();

    // DBUserProvider.dbc.getClientUser(1).then((res){
    //   registration = (res.reg == 1);
    //   userId = res.userIdServer;
    //   print("$userId Пользователя id" );
    //   print(registration);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                child: FutureBuilder<List<UserModel>>(
                  future: fetchPosts(http.Client(),
                      "https://delau.000webhostapp.com/flutter/getAllUsers.php"),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UserModel>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Center(child: CircularProgressIndicator());
                      default:
                        if (registration && snapshot.hasData) {
                          return ListView.builder(
                            padding: const EdgeInsets.only(
                                bottom: 0.0, top: 10.0, right: 0.0, left: 0.0),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              UserModel item = snapshot.data[index];
                              return Ink(
                                color: userId == item.id
                                    ? Color.fromRGBO(114, 103, 239, 1)
                                    : Colors.white,
                                child: ListTile(
                                  leading: Container(
                                    margin: new EdgeInsets.all(5.0),
                                    child: new Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Container(
                                          height: 37.0,
                                          width: 37.0,
                                          child: new Center(
                                            child: new Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      114, 103, 239, 1)),
                                            ),
                                          ),
                                          decoration: new BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: userId == item.id
                                                    ? Color.fromRGBO(
                                                        0, 0, 0, 0.6)
                                                    : Colors.transparent,
                                                offset: Offset(0.0, 1.0),
                                                blurRadius: 2,
                                              ),
                                            ],
                                            color: userId == item.id
                                                ? Colors.white
                                                : Colors.transparent,
                                            border: new Border.all(
                                                width: 1.0,
                                                color: userId == item.id
                                                    ? Colors.white
                                                    : Color.fromRGBO(
                                                        114, 103, 239, 1)),
                                            borderRadius: const BorderRadius
                                                    .all(
                                                const Radius.circular(20.0)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(
                                    '${item.name} ${item.surname}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'Exo 2',
                                      fontWeight: FontWeight.w300,
                                      color: userId == item.id
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle:
                                      get_subtitle_ratingPage(item, userId),
                                  trailing: Text(
                                    "${item.rating} / ${item.countDone} / ${item.countAdd}",
                                    style: TextStyle(
                                      color: userId == item.id
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            },
                          );
                        } else
                          return NoRegister();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50.0,
        backgroundColor: Colors.transparent,
        animationDuration: Duration(microseconds: 2500),
        items: <Widget>[
          Icon(
            Icons.list,
            size: 30,
            color: Colors.black54,
          ),
          Icon(
            FontAwesome.sticky_note_o,
            size: 30,
            color: Colors.black54,
          ),
          Icon(
            Icons.add,
            size: 30,
            color: Colors.black54,
          ),
          Icon(
            Icons.pie_chart_outlined,
            size: 30,
            color: Colors.deepPurpleAccent,
          ),
          Icon(
            FontAwesome.user_o,
            size: 30,
            color: Colors.black54,
          ),
        ],
        index: 3,
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/notes');
          }
          if (index == 2) {
            Navigator.pushNamed(context, '/second');
          }
          if (index == 3) {
            Navigator.pushNamed(context, '/rating');
          }
          if (index == 4) {
            Navigator.pushNamed(context, '/user');
          }
        },
      ),
    );
  }
}

// TODO : DELETE
class UserModel {
  final int id;
  final String name;
  final String surname;
  final String login;
  final String email;
  final String password;
  final int countDone;
  final int countAdd;
  final int rating;

  UserModel(
      {this.id,
      this.name,
      this.surname,
      this.login,
      this.email,
      this.password,
      this.countDone,
      this.countAdd,
      this.rating});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json['id']),
      name: json['name'] as String,
      surname: json['surname'] as String,
      login: json['login'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      countAdd: int.parse(json['countAdd']),
      countDone: int.parse(json['countDone']),
      rating: int.parse(json['rating']),
    );
  }
}

List<UserModel> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
}

Future<List<UserModel>> fetchPosts(http.Client client, String link) async {
  final response = await client.get(link);
  return parsePosts(response.body);
}

Widget get_subtitle_ratingPage(UserModel item, userId) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Column(
      children: <Widget>[
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            '${item.login}',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Exo 2',
              fontWeight: FontWeight.w500,
              color: userId == item.id
                  ? Colors.white
                  : Color.fromRGBO(114, 103, 239, 1),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget getNoRegist() {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[Text("Вы не зарегистрированы")]);
}

Widget returnRatingList(registration, userId) {
  return FutureBuilder<List<UserModel>>(
    future: fetchPosts(http.Client(),
        "https://delau.000webhostapp.com/flutter/getAllUsers.php"),
    builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
      if (registration && snapshot.hasData) {
        return ListView.builder(
          padding: const EdgeInsets.only(
              bottom: 0.0, top: 10.0, right: 0.0, left: 0.0),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            UserModel item = snapshot.data[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                padding: EdgeInsets.only(top: 6.0, left: 5.0),
                color: Colors.green[300],
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Icon(
                      FontAwesome.check,
                      color: Colors.white,
                    ),
                    Text(
                      "Выполнил",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'Exo 2',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              secondaryBackground: Container(
                padding: EdgeInsets.only(top: 6.0, right: 5.0),
                color: Colors.red[300],
                alignment: Alignment.centerRight,
                child: Column(
                  children: <Widget>[
                    Icon(
                      FontAwesome.close,
                      color: Colors.white,
                    ),
                    Text(
                      "Удалить",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: 'Exo 2',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              child: ListTile(
                  leading: Icon(
                    Icons.people,
                    color: Color.fromRGBO(114, 103, 239, 1),
                    size: 28.0,
                  ),
                  title: Text(
                    '${item.name} ${item.surname}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Exo 2',
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: get_subtitle_ratingPage(item, userId),
                  onTap: () {}),
            );
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
