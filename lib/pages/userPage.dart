import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/pages/userPageHelper.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  var countAdd = "Не можем получить";
  // var pos = all[0];
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ClientCounter>>(
        future: DBCountProvider.dbc.getClientCounterInList(),
        builder: (BuildContext context, AsyncSnapshot<List<ClientCounter>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                ClientCounter item = snapshot.data[0];
                return   
                    Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.75,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/profile.jpg"), fit: BoxFit.cover)),
                    child:Container(

                decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                        image: AssetImage("assets/ramk.png"), fit: BoxFit.fitWidth)),
                        ),
          ),
          Align(
            alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 45.0, top: 5),
                child:
                Column(children: <Widget>[
                    Text(" Пользователь       ",style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 36.0, fontWeight: FontWeight.w900, color: Colors.black)),
                    Text("  Неопознанный",style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 36.0, fontWeight: FontWeight.w900, color: Colors.black)),
                  ],
                )

         
                //  Text("Артем", 
                //   style: TextStyle(
                //   fontStyle: FontStyle.italic,
                //   fontFamily: "Exo 2",
                //   fontSize: 36.0, 
                //   fontWeight: FontWeight.w900, 
                //   color: Colors.black),
                //   ),
                ),
              ),
              Divider(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child:              
          Padding(
            padding: EdgeInsets.only( left: 45.0),
            child: Row(children: <Widget>[
             new FloatingActionButton(
              mini: true,
              heroTag: "btn_inslider_numberlsldsdlskdlsd",
              child:
              Container(
                decoration:  new BoxDecoration(
                boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(71, 9, 150, 0.17),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                      ),
                    ],
                gradient: new LinearGradient(
                      colors: [
                      Color.fromRGBO(162, 122, 246, 1),
                      Color.fromRGBO(114, 103, 239, 1),
                      // Color.fromRGBO(81, 20, 219, 1),
                      // Color.fromRGBO(31, 248, 169, 1),
                      ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp
                    ),
                    border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(50),

                ),
                child: Center(
                  child: Icon(Icons.add,
                  size: 20,),
                ),
              ), 
            ),
                      Padding(
            padding: EdgeInsets.only( left: 10.0),
            child:
            Text("Создано задач: ${item.countAdd.toString()}",
             style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)),
                      ),
            ],
            ),
          )
          ),

                    Align(
            alignment: Alignment.centerLeft,
            child:              
          Padding(
            padding: EdgeInsets.only( left: 45.0, top: 5),
            child: Row(children: <Widget>[
             new FloatingActionButton(
              mini: true,
              heroTag: "btn_inslider_numberlsldsdlskdlasdasdsd",
              child:
              Container(
                decoration:  new BoxDecoration(
                boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(71, 9, 150, 0.17),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                      ),
                    ],
                gradient: new LinearGradient(
                      colors: [
                      Color.fromRGBO(162, 122, 246, 1),
                      Color.fromRGBO(114, 103, 239, 1),
                      // Color.fromRGBO(81, 20, 219, 1),
                      // Color.fromRGBO(31, 248, 169, 1),
                      ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp
                    ),
                    border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(50),

                ),
                child: Center(
                  child: Icon(FontAwesome.check,
                  size: 20,),
                ),
              ), 
            ),
                      Padding(
            padding: EdgeInsets.only( left: 10.0),
            child:
            Text("Выполненно задач: ${item.countDone.toString()}", style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)),
                      ),
            ],
            ),
          )
          ),

                    Align(
            alignment: Alignment.centerLeft,
            child:              
          Padding(
            padding: EdgeInsets.only( left: 45.0, top: 5),
            child: Row(children: <Widget>[
             new FloatingActionButton(
              mini: true,
              heroTag: "btn_inslider_numberlsldsdlskdlsdssdsad",
              child:
              Container(
                decoration:  new BoxDecoration(
                boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(71, 9, 150, 0.17),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                      ),
                    ],
                gradient: new LinearGradient(
                      colors: [
                      Color.fromRGBO(162, 122, 246, 1),
                      Color.fromRGBO(114, 103, 239, 1),
                      // Color.fromRGBO(81, 20, 219, 1),
                      // Color.fromRGBO(31, 248, 169, 1),
                      ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp
                    ),
                    border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(50),

                ),
                child: Center(
                  child: Icon(FontAwesome.thumbs_up,
                  size: 20,),
                ),
              ), 
            ),
                      Padding(
            padding: EdgeInsets.only( left: 10.0),
            child:
            Text("Рейтинг: ${((item.countDone/item.countAdd)*100).toString()}", style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)),
                      ),
            ],
            ),
          )
          ),

        ],
      );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
            bottomNavigationBar: CurvedNavigationBar(
        height: 50.0,
        backgroundColor: Colors.transparent,
        animationDuration: Duration(microseconds: 2500),
        items: <Widget>[
          Icon(Icons.list, size: 30, color: Colors.black,),
          Icon(Icons.add, size: 30, color: Colors.black,),
          Icon(FontAwesome.user_o, size: 30, color: Colors.black,),
          // Icon(Icons.compare_arrows, size: 30, color: Colors.black,),
          // Icon(Icons.add, size: 30, color: Colors.black,),
          // Icon(Icons.list, size: 30, color: Colors.black,),
        ],
        index: 2,
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          if(index == 0){
            Navigator.pushNamed(context, '/');
          }
          if(index == 1){
            Navigator.pushNamed(context, '/second/1');
          }
          if(index == 2){
            Navigator.pushNamed(context, '/user');
          }
        }
      ),
      );
  }
}

// foo() async {
//   final user = await DBCountProvider.dbc.getClientCounter(0);
//   return user;
// }