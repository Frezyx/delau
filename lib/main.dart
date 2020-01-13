import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'addTaskPage.dart';
import 'widgets_helper.dart';
import 'postPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:delau/widget/notification.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:speech_recognition/speech_recognition.dart';
// import 'package:delau/pages/bottomBar.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
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
      // '/services':(BuildContext context) => Services(),
    },
    onGenerateRoute: (RouteSettings){
      var path = RouteSettings.name.split('/');
      if(path[1] == 'second'){
        return new MaterialPageRoute(builder: (context) => new MyStatefulWidget3(id:path[2]),
        settings: RouteSettings);
        }
      
      if(path[1] == 'postPage'){
        return new MaterialPageRoute(builder: (context) => new PostPage(id:path[2]),
        settings: RouteSettings);
        }

      },
    );
  }
}

class Post {
  final int id;
  final String post_header;
  final String post_body;
  final String time_zd;
  final String date_zd;
  final int marker;
  final int paginator;
 
  Post({ this.id, this.post_header, this.post_body,
   this.date_zd, this.time_zd, this.marker,
   this.paginator});
 
  factory Post.fromJson(Map<String, dynamic> json) {
    // print(json['id'].toString());
    return Post(
      // userId: json['userId'] as int,
      id: int.parse(json['id']),
      post_header: json['post_header'] as String,
      post_body: json['post_body'] as String,
      time_zd: json['time-zd'] as String,
      date_zd: json['date-zd'] as String,
      marker: int.parse(json['marker']),
      paginator: int.parse(json['paginator']),
    );
  }
}

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
 
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

Future<List<Post>> fetchPosts(http.Client client) async {
  final response = await client.get('https://delau.000webhostapp.com/flutter/get.php');
  var data = jsonDecode(response.body);
    //print(data.toString());
  // compute function to run parsePosts in a separate isolate
  return parsePosts(response.body);
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

class ListViewPosts extends StatelessWidget {
  final List<Post> posts;
 
  ListViewPosts({Key key, this.posts}) : super(key: key);
 
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
    return Container(
      child: ListView.builder(
          itemCount: posts.length,
          padding: const EdgeInsets.only(bottom: 10.0, top: 5.0, right: 15.0, left:15.0),
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                ListTile(
                  // contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  leading: Icon(i_add[posts[position].marker],
                    color: Color.fromRGBO(114, 103, 239, 1),
                    size: 24.0,
                  ),
                  title: 
                  Text('${posts[position].post_header}',
                    style: TextStyle(fontSize: 18.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w300,),
                    overflow: TextOverflow.ellipsis,
                    ),

                  subtitle: get_subtitle(posts, position),
                  //  Text('Дата: ${posts[position].date_zd.toString().substring(5,10)}      Время: ${posts[position].time_zd.toString().substring(0,5)}',
                                    // ),
                  trailing:
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: 'Next page',
                    onPressed: (){
                      httpGet("https://delau.000webhostapp.com/flutter/delete.php?id="+posts[position].id.toString());
                      posts.removeAt(position);

                    },
                  ),
                  onTap: () {
                    _onTapItem(context, posts[position]);
                    Navigator.pushNamed(context, '/postPage/${posts[position].id}');
                  }
                ),
                // StarDisplay(value: posts[position].paginator ~/ 2),
                Divider(height: 5.0),
              ],
            );
          }),
    );
  }
 
  void _onTapItem(BuildContext context, Post post) {

  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

// РОУТИННГ
  // int curentTab = 0;

  // final List<Widget> screens =[
  //   MyStatefulWidget(),
  // ];
  // SpeechRecognition _speechRecognition;
  // bool _isAvailable = false;
  // bool _isListerning = false;
  // String resultText = "";

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



  // Future<List<Post>> posters = fetchPosts(http.Client());
  Widget getPreviewData(AsyncSnapshot<List<Post>> snapshot){
    return snapshot.hasData
              ? ListViewPosts(posts: snapshot.data) // return the ListView widget
              : Center(child: CircularProgressIndicator());
  }

  Future<List<Post>> buildCountWidget() {
    return  fetchPosts(http.Client());
  }

  // void refresher() async{
  //   setState(() {
  //   const oneSecond = const Duration(seconds: 10);
  //   new Timer.periodic(oneSecond, (Timer t) =>  setState((){}));
  // });
  // }

  @override
  void initState() {

  super.initState();
    setState(() {
      const oneSecond = const Duration(seconds: 1);
      new Timer.periodic(oneSecond, (Timer t) =>  setState((){}));
    });

    // initSpeechRecognizer();
  }

  // void initSpeechRecognizer(){
  //   _speechRecognition = SpeechRecognition();

  //   _speechRecognition.setAvailabilityHandler(
  //     (bool result) => setState(() => _isAvailable = result),
  //     );

  //   _speechRecognition.setRecognitionStartedHandler(
  //     () => setState(() => _isListerning = true),
  //     );

  //   _speechRecognition.setRecognitionResultHandler(
  //     (String speech) => setState(() => resultText = speech),
  //     );
    
  //   _speechRecognition.setRecognitionCompleteHandler(
  //     () => setState(() => _isListerning = false),
  //     );
    
  //   _speechRecognition.activate().then(
  //     (result) => setState(()=> _isAvailable = result),
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    // new Timer.periodic(oneSecond, (Timer t) => setState((){}));
    return Scaffold(
          // appBar: new AppBar(
          //   title: new Text("csd"),
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          // ),
          //  appBar: AppBar(
          //     backgroundColor: Colors.transparent,
          //     title: const Text('DELAU'),
          //     centerTitle: true,
          //     actions: <Widget>[
          //     IconButton(
          //       icon: const Icon(Icons.speaker_notes),
          //       tooltip: 'Next page',
          //       onPressed: () {
          //         // speak();
          //       },
          //     ),
          //     IconButton(
          //       icon: const Icon(Icons.notification_important),
          //       tooltip: 'Show Snackbar',
          //       onPressed: () {
                
          //       },
          //     ),
          //   ],
          // ),

      body:
      SafeArea(
        bottom: false,
        top: false,
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
                    // gradient: new LinearGradient(
                    //   colors: [
                    //   Color.fromRGBO(162, 122, 246, 1),
                    //   Color.fromRGBO(114, 103, 239, 1),
                    //   // Color.fromRGBO(81, 20, 219, 1),
                    //   // Color.fromRGBO(31, 248, 169, 1),
                    //   ],

                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomLeft,
                    // stops: [0.0,1.0],

                    //   tileMode: TileMode.clamp),
                    // color: Color.fromRGBO(114, 103, 239, 1),
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
          height: 280.0,
          autoPlay: true,
          autoPlayCurve: Curves.elasticIn,
          autoPlayDuration: const Duration(milliseconds: 2800),
          // border: UnderlineInputBorder(
          // borderRadius:BorderRadius.circular(5.0)),
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
                              // image: DecorationImage(
                              //     image: NetworkImage(
                              //         'https://placeimg.com/320/240/any'),fit: BoxFit.fill)),
        ),
        
         Expanded(
          child: Container(
            child: FutureBuilder<List<Post>>(
            future: buildCountWidget(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
          
              return getPreviewData(snapshot);
            },
          ),
          ),
        ),

      ],
      ), 
      ),

    
      bottomNavigationBar:
             BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: Container(
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                      padding: EdgeInsets.only( left: 0.0, top: 15, bottom: 15, ),
                      onPressed: () {
                        // if(_isAvailable && ! _isListerning)
                        // {
                        //   _speechRecognition.listen(locale: "ru_RU").then(
                        //     (result) => print('$result')
                        //   );
                        // }
                      },
                      child: 
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Icon(Icons.calendar_today,size: 20.0,),
                          Text(
                              "Старт",
                              style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
                            ),
                        ],
      
                      ),
                    ),
      
                    FlatButton(
                      color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                      padding: EdgeInsets.only( left: 0.0, top: 15, bottom: 15),
                      onPressed: () {
                        // if(_isListerning){
                        //   _speechRecognition.stop().then(
                        //     (result) => setState(() => _isListerning = result));
                          
                        // }
                      },
                      child: 
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Icon(Icons.perm_contact_calendar,size: 20.0,),
                          Text(
                              "Стоп",
                              style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
                            ),
                        ],
      
                      ),
                    ),
      
                    FlatButton(
                      color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                      padding: EdgeInsets.only( left: 60.0, top: 15, bottom: 15),
                      onPressed: () {
                        // if(_isListerning){
                        //   _speechRecognition.cancel().then(
                        //     (result) => setState((){
                        //       _isListerning = result;
                        //       resultText = "";
                        //     })
                        //   );
                        // }
                      },
                      child: 
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Icon(Icons.perm_contact_calendar,size: 20.0,),
                          Text(
                              "Очистить",
                              style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
                            ),
                        ], 
                      ),
                    ),
      
                                  FlatButton(
                      color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                      padding: EdgeInsets.only(left: 0.0, top: 15, bottom: 15),
                      onPressed: () {
                        Navigator.pushNamed(context, '/ntf');
                      },
                      child: Text(
                        "Поиск",
                        style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: "btn_num_1",
              onPressed: () {
                // print("Я как бы нажался");
                Navigator.pushNamed(context, '/second/123');},
              child: Icon(Icons.add),
              backgroundColor: Color.fromRGBO(114, 103, 239, 1),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        }
}