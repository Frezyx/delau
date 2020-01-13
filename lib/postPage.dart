import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:delau/main.dart';


class Post {
  final int id;
  final String post_header;
  final String post_body;
  final String time_zd;
  final String date_zd;
  final String vazhnost_zd;
  final int marker;
 
  Post({ this.id, this.post_header,
   this.post_body, this.date_zd,
    this.time_zd, this.vazhnost_zd,
    this.marker});
 
  factory Post.fromJson(Map<String, dynamic> json) {
    // print(json['id'].toString());
    return Post(
      // userId: json['userId'] as int,
      id: int.parse(json['id']),
      post_header: json['post_header'] as String,
      post_body: json['post_body'] as String,
      time_zd: json['time-zd'] as String,
      date_zd: json['date-zd'] as String,
      vazhnost_zd: json['paginator'] as String,
      marker: int.parse(json['marker']),
    );
  }
}

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
 
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

Future<List<Post>> fetchPosts(http.Client client, String id) async {
  final response = await client.get('https://delau.000webhostapp.com/flutter/getId.php?id=$id');
  var data = jsonDecode(response.body);
    print(data.toString());
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

class ListViewPosts extends StatelessWidget {
  final List<Post> posts;

   List<String> backgrounds =[
    "assets/background/learning.jpg",
    "assets/background/working.jpg",
    "assets/background/sport.jpg",
    "assets/background/meet.jpg",
    "assets/background/shop.jpg",
    "assets/postBackground.jpg",
  ];
 
  ListViewPosts({Key key, this.posts}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return 
    Container(
            decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("${backgrounds[posts[0].marker]}"), fit: BoxFit.cover)),
                child:
    Container(
                  margin: new EdgeInsets.only(left: 50.0, right: 50.0, top: 200.0, bottom: 200.0),
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
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text('${posts[0].post_header}', style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.w500,),
                  ),
                 Text('${posts[0].post_body}', style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.w200,),
                  ),
                StarDisplay(value: int.parse(posts[0].vazhnost_zd) ~/ 2),
                Text(
                  'Дата: ${posts[0].date_zd.toString().substring(5,10)}      Время: ${posts[0].time_zd.toString().substring(0,5)}',
                  style: TextStyle(
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.w800,
                    fontSize: 13.0,
                    color: Color.fromRGBO(114, 103, 239, 1),
                  ),
                  ),
               ],
      ),
    ),
    );
  }
 
  void _onTapItem(BuildContext context, Post post) {

  }
}

class PostPage extends StatefulWidget {
  String _id;

  PostPage({String id}): _id = id;

  @override
  _PostPageState createState() => _PostPageState(_id);
}

class _PostPageState extends State<PostPage> {
  String id;

  _PostPageState(this.id);

  // Future<List<Post>> posters = fetchPosts(http.Client());
  Widget getPreviewData(AsyncSnapshot<List<Post>> snapshot){
    return snapshot.hasData
              ? ListViewPosts(posts: snapshot.data) // return the ListView widget
              : Center(child: CircularProgressIndicator());
  }

  Future<List<Post>> buildCountWidget() {
    return  fetchPosts(http.Client(),id);
  }
  @override
  Widget build(BuildContext context) {
    // new Timer.periodic(oneSecond, (Timer t) => setState((){}));
    return Scaffold(
           appBar: AppBar(
              // backgroundColor: Color.fromRGBO(76, 175, 80, 100),
              backgroundColor: Color.fromRGBO(114, 103, 239, 1),
              title: const Text('DELAU'),
              actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Next page',
                onPressed: () {
                  
                },
              ),
              IconButton(
                icon: const Icon(Icons.notification_important),
                tooltip: 'Show Snackbar',
                onPressed: () {
                
                },
              ),
            ],
          ),

      body: FutureBuilder<List<Post>>(
        future: buildCountWidget(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
      
          return getPreviewData(snapshot);
        },
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Row(
            children: <Widget>[
              FlatButton(
                color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                padding: EdgeInsets.only( left: 0.0, top: 15, bottom: 15, ),
                onPressed: () {
                  /*...*/
                },
                child: 
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Icon(Icons.calendar_today,size: 20.0,),
                    Text(
                        "Сегодня",
                        style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
                      ),
                  ],

                ),
              ),

              FlatButton(
                color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                padding: EdgeInsets.only( left: 0.0, top: 15, bottom: 15),
                onPressed: () {
                  /*...*/
                },
                child: 
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Icon(Icons.perm_contact_calendar,size: 20.0,),
                    Text(
                        "Завтра",
                        style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
                      ),
                  ],

                ),
              ),

              FlatButton(
                color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                padding: EdgeInsets.only( left: 60.0, top: 15, bottom: 15),
                onPressed: () {
                  /*...*/
                },
                child: 
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Icon(Icons.perm_contact_calendar,size: 20.0,),
                    Text(
                        "Календарь",
                        style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
                      ),
                  ],

                ),
              ),

                            FlatButton(
                color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
                padding: EdgeInsets.only(left: 0.0, top: 15, bottom: 15),
                onPressed: () {
                  /*...*/
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
        onPressed: () {Navigator.pushNamed(context, '/second/123');},
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(114, 103, 239, 1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
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
          size: 20.0,
        );
      }),
    );
  }
}