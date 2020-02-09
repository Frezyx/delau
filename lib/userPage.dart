import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delau/utils/synchroneHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/utils/RaisedGradienButton.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/pages/userPageHelper.dart';
import 'main.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  var countAdd = "Не можем получить";
  bool registration = false;
  var name = "Пользователь";
  var surname = "Неопознанный";
  var imgSrc = "assets/profile.jpg";
  // Widget userWidget;
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(114, 103, 239, 1),  
                    Color.fromRGBO(162, 122, 246, 1)],
  ).createShader(Rect.fromLTWH(100.0, 0.0, 200.0, 50.0));

  @override
  void initState() {
    super.initState();

    DBUserProvider.dbc.getClientUser(1).then((res){
      registration = (res.reg == 1);
      print(registration);
    });
      // getSyncStatus().then((synchronise){
      //   synchrone = synchronise; 
      // });
    
    // if(synchrone){
    //   surname = "Опознанный";
    //   name = "Польз";
    //   userWidget = userData(name, surname);
    // }
  }
  // var pos = all[0];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List<ClientUser>>(
        future: DBUserProvider.dbc.getClientUserInList(),
        builder: (BuildContext context, AsyncSnapshot<List<ClientUser>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                ClientUser item = snapshot.data[0];
                return   
                    Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.75,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("$imgSrc"), fit: BoxFit.cover)),
                    child:Container(

                decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                        image: AssetImage("assets/ramk.png"), fit: BoxFit.fitWidth)),
                        ),
          ),

          registration ? userData(item.name, item.surname, context) : getLoginButton(context, linearGradient),

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
            Text("Рейтинг: ${item.rating.toString()}", style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)),
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
          Icon(Icons.list, size: 30, color: Colors.black54,),
          Icon(FontAwesome.sticky_note_o, size: 30, color: Colors.black54,),
          Icon(Icons.add, size: 30, color: Colors.black54,),
          Icon(Icons.pie_chart_outlined, size: 30, color: Colors.black54,),
          Icon(FontAwesome.user_o, size: 30, color: Colors.deepPurpleAccent,),
          // Icon(Icons.compare_arrows, size: 30, color: Colors.black,),
          // Icon(Icons.add, size: 30, color: Colors.black,),
          // Icon(Icons.list, size: 30, color: Colors.black,),
        ],
        index: 4,
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
        }
      ),
      );
  }
}

Widget userData(String name, String surname, context){
  return Align(
            alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 45.0, top: 13),
                child:
                Row(
                  children: <Widget>[
                          Text("$name $surname",style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 36.0, fontWeight: FontWeight.w900, color: Colors.black)),
                                    IconButton(
                                      iconSize: 32,
                                      icon: Icon(Icons.settings),
                                      color: Color.fromRGBO(114, 103, 239, 1),
                                      splashColor: Color.fromRGBO(114, 103, 239, 1),
                                      onPressed: (){
                                        Navigator.pushNamed(context, '/update');
                                      },
                                    ),
                          // Text("$surname",style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 36.0, fontWeight: FontWeight.w900, color: Colors.black))
                  ],
                ),
                ),
              );
}

Widget getLoginButton(context, linearGradient){
  return  
  // RaisedButton(
  //                 child:
  //             Container(
  //               decoration:  new BoxDecoration(
  //               boxShadow:<BoxShadow>[
  //                     BoxShadow(
  //                       color: Color.fromRGBO(71, 9, 150, 0.17),
  //                       offset: Offset(0.0, 4.0),
  //                       blurRadius: 15.0,
  //                     ),
  //                   ],
  //               gradient: new LinearGradient(
  //                     colors: [
  //                     Color.fromRGBO(162, 122, 246, 1),
  //                     Color.fromRGBO(114, 103, 239, 1),
  //                     // Color.fromRGBO(81, 20, 219, 1),
  //                     // Color.fromRGBO(31, 248, 169, 1),
  //                     ],
  //                   begin: Alignment.topRight,
  //                   end: Alignment.bottomLeft,
  //                   stops: [0.0,1.0],
  //                   tileMode: TileMode.clamp
  //                   ),
  //                   // border: Border.all(
  //                   //       color: Colors.transparent,
  //                   //       width: 0,
  //                   //     ),
  //                   //     borderRadius: BorderRadius.circular(50),

  //               ),
  //               child: 
  //                 Text('Зарегистрироваться', style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0, fontWeight: FontWeight.w900,),),
  //             ), 
  //           // child: Text('Зарегистрироваться', style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0, fontWeight: FontWeight.w900,),),
  //           color: Color.fromRGBO(114, 103, 239, 1), textColor: Colors.white,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //           onPressed: () {},
  //         );
  // Center(
  //   child:
  // RaisedGradientButton(
  // child: Text(
  //   'Button',
  //   style: TextStyle(color: Colors.white),
  // ),
  // gradient: LinearGradient(
  //   colors: <Color>[Colors.green, Colors.black],
  // ),
  // onPressed: (){
  //   print('button clicked');
  // }
  // ),
  // ); 
  Column(
    children: <Widget>[
      Padding(
    padding: EdgeInsets.only(right: 45.0, left: 45.0),
    child:
Container(
      // decoration: const BoxDecoration(
      // boxShadow:<BoxShadow>[
      //                 BoxShadow(
      //                   color: Color.fromRGBO(71, 9, 150, 0.2),
      //                   offset: Offset(0.0, 4.0),
      //                   blurRadius: 7.0,
      //                 ),
      //               ],
      // ),
  child:
  RaisedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/reg');
   },
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  padding: const EdgeInsets.all(0.0),
  child: Ink(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
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
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    child: Container(
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 40.0), // min sizes for Material buttons
      alignment: Alignment.center,
      child: Text('Зарегистрироваться', textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.white),),
      ),
    ),
  ),
  ),
),
 Padding(
    padding: EdgeInsets.only(right: 45.0, left: 45.0),
    child:
  RaisedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/autoriz');
   },
  highlightColor : Colors.white,
  splashColor:  Color.fromRGBO(114, 103, 239, 1),
  shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  side: BorderSide(color: Color.fromRGBO(114, 103, 239, 1))
                ),
  color: Colors.white,
  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  padding: const EdgeInsets.all(0.0),
    child: Container(
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 40.0), // min sizes for Material buttons
      alignment: Alignment.center,
      child: Text('Войти', textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0, fontWeight: FontWeight.w900,
      //  color: Color.fromRGBO(114, 103, 239, 1)
      foreground: Paint()..shader = linearGradient,
       ),),
      ),
  ),
),

    ]
  );
}

// foo() async {
//   final user = await DBUserProvider.dbc.getClientUser(0);
//   return user;
// }

