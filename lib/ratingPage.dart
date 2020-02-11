import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:delau/utils/ttsHelper.dart';
import 'package:flutter/material.dart';
import 'widgets_helper.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/pages/userSettings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;


class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {

var countTask =  DBProvider.db.getContNow();
bool registration = false;
// РОУТИННГ

    @override
    void initState(){
      super.initState();

      DBUserProvider.dbc.getClientUser(1).then((res){
        registration = (res.reg == 1);
        print(registration);
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
        Column(
        children: [
        SizedBox( height: 20.0),
        Expanded(
          child: Container( 
          child:  FutureBuilder<List<UserModel>>(
          future: fetchPosts(http.Client(), "https://delau.000webhostapp.com/flutter/getAllUsers.php"),
          builder:
          (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (registration && snapshot.hasData) 
            {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 0.0, top: 10.0, right: 0.0, left:0.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                UserModel item = snapshot.data[index];
                return ListTile(
                    leading:
                    Container(
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
                                  color: Color.fromRGBO(114, 103, 239, 1)
                                ),
                                ),
                                      //fontWeight: FontWeight.bold,
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.transparent,
                              border: new Border.all(
                                  width: 1.0,
                                  color: Color.fromRGBO(114, 103, 239, 1)),
                              borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(4),
                    //   child: Text(
                    //   (index + 1).toString()
                    // ),
                    // ),
                  //    Icon(
                  //   Icons.people,
                  //   color: Color.fromRGBO(114, 103, 239, 1),
                  //   size: 28.0,
                  // ),
                    title: Text('${item.name} ${item.surname}',
                    style: TextStyle(fontSize: 18.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w300,),
                    overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: get_subtitle_ratingPage(item),
                    trailing: Text(
                      "${item.rating} / ${item.countDone} / ${item.countAdd}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
              },
            );

          } 
          
          else 
          {
            return Center(child: CircularProgressIndicator());
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
      Icon(Icons.list, size: 30, color: Colors.black54,),
      Icon(FontAwesome.sticky_note_o, size: 30, color: Colors.black54,),
      Icon(Icons.add, size: 30, color: Colors.black54,),
      Icon(Icons.pie_chart_outlined, size: 30, color: Colors.deepPurpleAccent,),
      Icon(FontAwesome.user_o, size: 30, color: Colors.black54,),
      // Icon(Icons.compare_arrows, size: 30, color: Colors.black,),
      // Icon(Icons.add, size: 30, color: Colors.black,),
      // Icon(Icons.list, size: 30, color: Colors.black,),
    ],
    index: 3,
    animationCurve: Curves.bounceInOut,
    onTap: (index) {
      if(index == 0){
        Navigator.pushNamed(context, '/');
      }
      if(index == 2){
        Navigator.pushNamed(context, '/second');
      }
      if(index == 3){
        Navigator.pushNamed(context, '/rating');
      }
      if(index == 4){
        Navigator.pushNamed(context, '/user');
      }
    },
  ),
          );
        }
}

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
 
  UserModel({ this.id, this.name, this.surname,
   this.login, this.email, this.password,
   this.countDone, this.countAdd, this.rating });
 
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // print(json['done'].toString());
    return UserModel(
      // userId: json['userId'] as int,
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
  // var data = jsonDecode(response.body);
    //print(data.toString());
  // compute function to run parsePosts in a separate isolate
  // print(" Вернул -->"+ response.body);
  return parsePosts(response.body);
}

Widget get_subtitle_ratingPage(UserModel item){
  return 
  Align(
    alignment: AlignmentDirectional.centerStart,
    child:
    Column(
      children: <Widget>[
      Align(
      alignment: AlignmentDirectional.centerStart,
      child:
        Text(
          '${item.login}',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w500, color:  Color.fromRGBO(114, 103, 239, 1),
              ),
            ),
          ),
      // Align(
      // alignment: AlignmentDirectional.centerStart,
      // child:
      //   StarDisplay(value: item.priority ~/ 2),
      // ),
      ],
    ),
  );
}

// Widget getRatingList(){
//   DBUserProvider.dbc.getClientUser(1).then((res){
//     var registration = (res.reg == 1);


//   if(registration){
//     print("Зареган");
//     returnRatingList();
//   }else{
//       getNoRegist();
//   }
//   });
// }

Widget getNoRegist(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    Text("Вы не зарегистрированы")
  ]);
}
Widget returnRatingList(registration){
  return 
  FutureBuilder<List<UserModel>>(
          future: fetchPosts(http.Client(), "https://delau.000webhostapp.com/flutter/getAllUsers.php"),
          builder:
          (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (registration && snapshot.hasData) 
            {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 0.0, top: 10.0, right: 0.0, left:0.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                UserModel item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: 
                  Container(
                    padding: EdgeInsets.only( top: 6.0, left: 5.0),
                    color: Colors.green[300],
                    alignment: Alignment.centerLeft,
                      child: Column(
                  children: <Widget>[
                        Icon(
                        FontAwesome.check,
                        color: Colors.white,
                  ),
                  Text("Выполнил", 
                  style: TextStyle(
                    color: Colors.white,
                     fontSize: 14.0,
                      fontFamily: 'Exo 2',
                       fontWeight: FontWeight.w600,),),
                  ],
                  ),
                  ),
                  secondaryBackground:
                   Container(
                    padding: EdgeInsets.only( top: 6.0, right: 5.0),
                    color: Colors.red[300],
                    alignment: Alignment.centerRight,
                      child: Column(
                  children: <Widget>[
                        Icon(
                        FontAwesome.close,
                        color: Colors.white,
                  ),
                  Text("Удалить", 
                  style: TextStyle(
                    color: Colors.white,
                     fontSize: 14.0,
                      fontFamily: 'Exo 2',
                       fontWeight: FontWeight.w600,),),
                  ],
                  ),
                  ),
                  child: ListTile(
                    leading: Icon(
                    Icons.people,
                    color: Color.fromRGBO(114, 103, 239, 1),
                    size: 28.0,
                  ),
                    title: Text('${item.name} ${item.surname}',
                    style: TextStyle(fontSize: 18.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w300,),
                    overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: get_subtitle_ratingPage(item),
                    // trailing: Checkbox(
                    //   onChanged: (bool value) {
                        
                    //     DBProvider.db.blockOrUnblock(item);
                    //     setState(() {
                          
                    //     });
                    //   },
                    //   value: item.done,
                    // ),
                    onTap: () {
                    // _onTapItem(context, item);
                    // Navigator.pushNamed(context, '/postPage/${item.id}');
                  }
                  ),
                );
              },
            );

          } 
          
          else 
          {
            return Center(child: CircularProgressIndicator());
          }

        },
      );
}