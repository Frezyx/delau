import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delau/utils/ttsHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'addTaskPage.dart';
import 'widgets_helper.dart';
import 'pages/postPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delau/widget/notification.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/userPage.dart';
import 'package:delau/addTaskPage.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delau/firstStartPages/demo.dart';
import 'package:delau/pages/tts.dart';
import 'package:delau/pages/addMarker.dart';
import 'package:delau/pages/userSettings.dart';
import 'package:delau/utils/fcm.dart';
import 'package:delau/reg.dart';
import 'package:delau/autoriz.dart';
import 'package:delau/utils/synchroneHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:speech_recognition/speech_recognition.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  SharedPreferences prefs = await SharedPreferences.getInstance(); // Хранилище 
  bool banner = (prefs.getBool('banner') ?? true);

  runApp(
    // bannerOne(prefs)
    (banner) ? bannerOne(prefs) : MyApp(),
    );
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    routes: {
      '/':(BuildContext context) => MyStatefulWidget(),
      '/second':(BuildContext context) => MyStatefulWidget3(),
      '/ntf':(BuildContext context) => LocalNotificationWidget(),
      '/new':(BuildContext context) => MP(),
      '/user':(BuildContext context) => User(),
      '/tts':(BuildContext context) => TTS(),
      '/fcm':(BuildContext context) => FCMPage(),
      '/reg':(BuildContext context) => RegistrationPage(),
      '/autoriz':(BuildContext context) => AutorizationPage(),
      '/addMark':(BuildContext context) => AddMarkerPage(),
      '/update':(BuildContext context) => UpdatePage(),
      // '/services':(BuildContext context) => Services(),
    },
    onGenerateRoute: (RouteSettings){
      var path = RouteSettings.name.split('/');
      // if(path[1] == 'second'){
      //   return new MaterialPageRoute(builder: (context) => new MyStatefulWidget3(id:path[2]),
      //   settings: RouteSettings);
      //   }
      
      if(path[1] == 'postPage'){
        return new MaterialPageRoute(builder: (context) => new PostPage(id:path[2]),
        settings: RouteSettings);
        }

      },
    );
  }
}

httpGet(String link) async{
    try{
      var response = await http.get('$link');
      print("Статус ответа: ${response.statusCode}");
      print("Тело ответа: ${response.body}");
    } catch (error){
      print('Ты ебловоз блять! А вот твоя ошибка: $error');
    }
  }

// Future<bool> getSyncStatus() async{

//   bool reg = false;
//   DBUserProvider.dbc.getClientUser(1).then((res){
//     print(res.reg);
//     reg = (res.reg == 1); //Если 1 -> зареган -> True -> делаем синхронизацию;
//   });

//   try {
//   final result = await InternetAddress.lookup('google.com');
//     return result.isNotEmpty && result[0].rawAddress.isNotEmpty && reg;
//   } on SocketException catch (_) {
//     return false;
//   }
// }

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

var countTask =  DBProvider.db.getContNow();
bool registration = false;
// РОУТИННГ
  void refreshCount() {
    // reload
    setState(() {
      countTask =  DBProvider.db.getContNow();
    });
  }

    @override
    void initState(){
      super.initState();

      DBUserProvider.dbc.getClientUser(1).then((res){
        registration = (res.reg == 1);
        print(registration);
      });
    }

  List<String> slider_titles = [
    "Учеба",
    "Работа",
    "Спорт",
    "Встречи",
    "Покупки",
    "Другое"];

  List<IconData> i_add = [
    FontAwesome.book,
    FontAwesome.briefcase,
    MdiIcons.fromString('basketball'),
    FontAwesome.users, 
    MdiIcons.fromString('shopping'),
    FontAwesome.spinner
    ];

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
          DecoratedBox(  // add this
            child: new Column(
        children: <Widget>[
         CarouselSlider(
          items: [
            1,
            2,
            3,
            4,
            5,
            6].map((i) {
            return new Builder(
              builder: (BuildContext context) {
                return new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 70.0, bottom: 50.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(71, 9, 150, 0.37),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                      ),
                    ],
                        border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(12),
                  ),
                  child: getCardInfo(i, i_add, slider_titles)
                );
              },
            );
          }).toList(),
          height: 260.0,
          autoPlay: true,
          autoPlayCurve: Curves.elasticIn,
          autoPlayDuration: const Duration(milliseconds: 2800),
            ),
           ]
          ),

           decoration: BoxDecoration(
            //  color: Color.fromRGBO(114, 103, 239, 0.4),
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

                      tileMode: TileMode.clamp),
           ),
        ),
        Padding(
          
          padding: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),

        child: DecoratedBox(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.19),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 20.0,
                      ),
                    ],
                        border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                  ),
                  child: 
         Container(
           padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 2.0, bottom: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child:

            new FutureBuilder<int>(
              future: countTask,
            // stream: _streamController.stream, // Создаем и открываем поток
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
             // Наши данные из потока
             return
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 10.0, top: 2.0, bottom: 2.0),
                      child: Icon(FontAwesome.tasks, color: Color.fromRGBO(114, 103, 239, 1),size: 24),
                    ),
                  ),
                  TextSpan(text: 'Всего задач: ${snapshot.data.toString()}',
                    style: TextStyle(fontSize: 22.0,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.w300,)),
                ],
              ),
            );
            }),
          ),
                Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 2.0, bottom: 2.0),
                    child: 
                    RawMaterialButton(
                            onPressed: () {
                              getVoiceInfo();
                              // askPermision();
                              //   if(_isAvailable && ! _isListerning)
                              //   {
                              //       // httpGet("https://delau.000webhostapp.com/flutter/addTask.php?header=1&body=1&date=2020-01-15&time=24:13:00&marker=1&paginator=1");
                              //   _speechRecognition.listen(locale: "ru_RU").then((result) => print("aaaaa"));
                                
                              // }
                            },
                            child: new Icon(
                              FontAwesome.bullhorn,
                              size: 27,
                              color: Color.fromRGBO(114, 103, 239, 1),
                        ),
                        shape: new CircleBorder(),
                        elevation: 4,
                        hoverElevation: 10,
                        constraints: BoxConstraints.tight(Size(36, 36)),
                        fillColor: Colors.white,
                        // padding: EdgeInsets.all(2.0),
                    ),
                ),
                // Padding(
                //     padding: EdgeInsets.only(left: 0.0, right: 5.0, top: 2.0, bottom: 2.0),
                //     child: 
                //     RawMaterialButton(
                //             onPressed: () {
                //               Navigator.pushNamed(context, '/fcm');
                //             },
                //             child: new Icon(
                //               Icons.add,
                //               size: 27,
                //               color: Color.fromRGBO(114, 103, 239, 1),
                //         ),
                //         shape: new CircleBorder(),
                //         elevation: 4,
                //         hoverElevation: 10,
                //         constraints: BoxConstraints.tight(Size(36, 36)),
                //         fillColor: Colors.white,
                //         // padding: EdgeInsets.all(2.0),
                //     ),
                // ),
          ],),
          ),
        ),
        ),
        
         Expanded(
          child: Container(
            child: FutureBuilder<List<Client>>(
        future: DBProvider.db.getAllTasks(),
        builder:
         (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) 
          {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 0.0, top: 10.0, right: 0.0, left:0.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];
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
                  // confirmDismiss: (DismissDirection direction) async {
                  //   final bool res = await showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: const Text("Подтвердите действие"),
                  //         content: const Text("Are you sure you wish to delete this item?"),
                  //         actions: <Widget>[
                  //           FlatButton(
                  //             onPressed: () => Navigator.of(context).pop(true),
                  //             child: const Text("DELETE")
                  //           ),
                  //           FlatButton(
                  //             onPressed: () => Navigator.of(context).pop(false),
                  //             child: const Text("CANCEL"),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // },
                  // key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    DBProvider.db.deleteClient(item.id).then((priority){
                      refreshCount();
                      int pr = priority; 
                      counterDone(pr);
                    });
                    check().then((intenet) {
                      if (intenet != null && intenet && registration) {
                        print("synchromised");
                        httpGet("https://delau.000webhostapp.com/flutter/delete.php?id="+item.id.toString());
                      }
                    });
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color.fromRGBO(114, 103, 239, 1),
                        content: Text(
                          'Задача удалена',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                    i_add[item.marker],
                    color: Color.fromRGBO(114, 103, 239, 1),
                    size: 28.0,
                  ),
                    title: Text('${item.title}',
                    style: TextStyle(fontSize: 18.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w300,),
                    overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: get_subtitle_of_SQLI(item),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        //  httpGet("https://delau.000webhostapp.com/flutter/nodeletedone.php?id="+item.id.toString()); 
                        DBProvider.db.blockOrUnblock(item);
                        setState(() {
                          
                        });
                      },
                      value: item.done,
                    ),
                    onTap: () {
                    // _onTapItem(context, item);
                    Navigator.pushNamed(context, '/postPage/${item.id}');
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
      Icon(Icons.list, size: 30, color: Colors.deepPurpleAccent,),
      Icon(FontAwesome.sticky_note_o, size: 30, color: Colors.black54,),
      Icon(Icons.add, size: 30, color: Colors.black54,),
      Icon(Icons.pie_chart_outlined, size: 30, color: Colors.black54,),
      Icon(FontAwesome.user_o, size: 30, color: Colors.black54,),
      // Icon(Icons.compare_arrows, size: 30, color: Colors.black,),
      // Icon(Icons.add, size: 30, color: Colors.black,),
      // Icon(Icons.list, size: 30, color: Colors.black,),
    ],
    index: 0,
    animationCurve: Curves.bounceInOut,
    onTap: (index) {
      if(index == 0){
        Navigator.pushNamed(context, '/');
      }
      if(index == 2){
        Navigator.pushNamed(context, '/second');
      }
      if(index == 4){
        Navigator.pushNamed(context, '/user');
      }
    },
  ),
          );
        }
}


  void counterDone(int pr) async{
    await DBUserProvider.dbc.updateCountDone(pr);
  }

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          color: index < value ? Colors.yellow : Colors.black12,
          size: 16.0,
        );
      }),
    );
  }
}

class MP extends StatefulWidget {
  @override
  _MPState createState() => _MPState();
}

class _MPState extends State<MP> {
  // data for testing
  List<Client> testClients = [
    Client(title: "Raouf",
    description: "Rahiche",
    marker: 4,
    priority: 3,
    date: "2001-12-12",
    time: "22:22",
    done: false),
  ];
  List<IconData> i_add = [
    FontAwesome.book,
    FontAwesome.briefcase,
    MdiIcons.fromString('basketball'),
    FontAwesome.users, 
    MdiIcons.fromString('shopping'),
    FontAwesome.spinner
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter SQLite")),
      body: FutureBuilder<List<Client>>(
        future: DBProvider.db.getAllTasks(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBProvider.db.deleteClient(item.id);
                  },
                  child: ListTile(
                    title: Text(item.title),
                    leading: Text(item.id.toString()),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        DBProvider.db.blockOrUnblock(item);
                        setState(() {});
                      },
                      value: item.done,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Client rnd = testClients[math.Random().nextInt(testClients.length)];
          await DBProvider.db.newClient(rnd);
          setState(() {});
        },
      ),
    );
  }
}

