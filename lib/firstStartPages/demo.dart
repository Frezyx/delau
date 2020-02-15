import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:delau/utils/database_helper.dart';

Widget bannerOne(SharedPreferences prefs) {

  prefs.setBool('banner', false); 
  DBUserProvider.dbc.firstCreateTable();// Меняем значение на false
  DBNoteProvider.db.firstCreateTable().then((res){
    print(res.toString()+"Это id из Заметок");
  });
  DBMarkerProvider.db.firstCreateTable().then((res){
    print(res.toString()+"Это из Маркера");
  });

  return FirstPage();
}

class FirstPage extends StatefulWidget{
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String imgSrc = "assets/demoPage/demoBG.jpg";
  

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
    home: Scaffold(
    body:  
        DefaultTabController(
      length: 2,
      // Use a Builder here, otherwise DefaultTabController.of(context) below
      // returns null.
      child: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              
              Expanded(
                child: IconTheme(
                  data: IconThemeData(
                    size: 128.0,
                    color: Theme.of(context).accentColor,
                  ),
                  child: TabBarView(
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

                    Center(
                      child:
                      RaisedButton(
                        child: Text('Начать делать!'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ),
                    ],
                  ),
                ),
              ),
              // RaisedButton(
              //   child: Text('SKIP'),
              //   onPressed: () {
              //     final TabController controller =
              //         DefaultTabController.of(context);
              //     if (!controller.indexIsChanging) {
              //       controller.animateTo(kIcons.length - 1);
              //     }
              //   },
              // ),
              TabPageSelector(),
            ],
          ),
        ),
      ),
    )
  ),
  );
  }
}