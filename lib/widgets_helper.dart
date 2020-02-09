import 'package:flutter/material.dart';

import 'main.dart';
import 'models/dbModels.dart';


//КАРТОЧКА НА ГЛАВНОЙ СТРАНИЦЕ
Widget getCardInfo(int i, List<IconData> i_add, List<String>slider_titles){
    return Row(
      children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.0, left: 25.0),
            child:  new FloatingActionButton(
              heroTag: "btn_inslider_number"+i.toString(),
              child:
              new Container(
                decoration:  new BoxDecoration(
                boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(71, 9, 150, 0.37),
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
                  child: Icon(i_add[i-1]),
                ),
              ), 
                onPressed: () => {
                  // print("Жмяк")
                },
              ),
          ),
        ),
    // Align(
    //   alignment: AlignmentDirectional.centerStart,
    //   child: 
        Column(
            children: <Widget>[
              Padding(
              padding: EdgeInsets.only(top: 25, left: 20.0),
              child:  
              Text(slider_titles[i-1], 
                style: TextStyle(
                fontFamily: "Exo 2",
                fontSize: 30.0, 
                fontWeight: FontWeight.w100, 
                color: Colors.black),
                ),
            ),
            // Padding(
            //     padding: EdgeInsets.only(top: 2, left: 15),
            //     child:
            //       Text("Задач:",
            //         style: TextStyle(
            //         fontFamily: "Exo 2",
            //         fontSize: 14.0, 
            //         fontWeight: FontWeight.w300, 
            //         color: Color.fromRGBO(158, 158, 158, 1)),
            //       ),
            //     ),
            // Padding(
            //     padding: EdgeInsets.only(top: 0, left: 15),
            //     child:
            //       Text("Выполненно:",
            //         style: TextStyle(
            //         fontFamily: "Exo 2",
            //         fontSize: 14.0, 
            //         fontWeight: FontWeight.w300, 
            //         color: Color.fromRGBO(158, 158, 158, 1)),
            //       ),
            //     ),
            // Padding(
            //     padding: EdgeInsets.only(top: 0, left: 15),
            //     child:  Text("Сейчас:",
            //         style: TextStyle(
            //         fontFamily: "Exo 2",
            //         fontSize: 14.0, 
            //         fontWeight: FontWeight.w300, 
            //         color: Color.fromRGBO(158, 158, 158, 1)),
            //       ),
            // ),
        ],
        ),
      ],
    );
  }

Widget get_subtitle_of_SQLI(Client item){
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
          'Дата: ${item.date.substring(5,10)}     Время: ${item.time.substring(10,15)}',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w500, color:  Color.fromRGBO(114, 103, 239, 1),
              ),
            ),
          ),
      Align(
      alignment: AlignmentDirectional.centerStart,
      child:
        StarDisplay(value: (item.priority == 0) ? 0 : item.priority ~/ 2),
      ),
      ],
    ),
  );
}


// ВЫВОД ИНФОРМАЦИИ ИЗ MySQL --------------------------------------< СМОТРИ СЮДА

// class Post {
//   final int id;
//   final String post_header;
//   final String post_body;
//   final String time_zd;
//   final String date_zd;
//   final int marker;
//   final int paginator;
//   final bool done;
 
//   Post({ this.id, this.post_header, this.post_body,
//    this.date_zd, this.time_zd, this.marker,
//    this.paginator, this.done,});
 
//   factory Post.fromJson(Map<String, dynamic> json) {
//     // print(json['done'].toString());
//     return Post(
//       // userId: json['userId'] as int,
//       id: int.parse(json['id']),
//       post_header: json['post_header'] as String,
//       post_body: json['post_body'] as String,
//       time_zd: json['time-zd'] as String,
//       date_zd: json['date-zd'] as String,
//       marker: int.parse(json['marker']),
//       paginator: int.parse(json['paginator']),
//       done: (int.parse(json['done']) == 0),
//     );
//   }
// }

// List<Post> parsePosts(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
 
//   return parsed.map<Post>((json) => Post.fromJson(json)).toList();
// }

// Future<List<Post>> fetchPosts(http.Client client) async {
//   final response = await client.get('https://delau.000webhostapp.com/flutter/get.php');
//   var data = jsonDecode(response.body);
//     //print(data.toString());
//   // compute function to run parsePosts in a separate isolate
//   return parsePosts(response.body);
// }


// class ListViewPosts extends StatelessWidget {
//   final List<Post> posts;
//   ListViewPosts({Key key, this.posts}) : super(key: key);
 
//   List<IconData> i_add = [
//     FontAwesome.book,
//     FontAwesome.briefcase,
//     MdiIcons.fromString('basketball'),
//     FontAwesome.users, 
//     MdiIcons.fromString('shopping'),
//     FontAwesome.spinner
//     ];

//     List<Client> testClients = [
//     Client(title: "Raouf", description: "Rahiche", done: false),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView.builder(
//           itemCount: posts.length,
//           padding: const EdgeInsets.only(bottom: 10.0, top: 5.0, right: 15.0, left:15.0),
//           itemBuilder: (context, position) {
//             return Column(
//               children: <Widget>[
//                 ListTile(
//                   // contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//                   leading: Icon(i_add[posts[position].marker],
//                     color: Color.fromRGBO(114, 103, 239, 1),
//                     size: 24.0,
//                   ),
//                   title: 
//                   Text('${posts[position].post_header}',
//                     style: TextStyle(fontSize: 18.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w300,),
//                     overflow: TextOverflow.ellipsis,
//                     ),
//                   subtitle: get_subtitle(posts, position),
//                   trailing: Checkbox(
//                     value: posts[position].done,
//                     onChanged: (bool value) {

//                      httpGet("https://delau.000webhostapp.com/flutter/nodeletedone.php?id="+posts[position].id.toString()); 
//                     }
//                   ),
//                   onTap: () {
//                     _onTapItem(context, posts[position]);
//                     Navigator.pushNamed(context, '/postPage/${posts[position].id}');
//                   }
//                 ),
//                 // StarDisplay(value: posts[position].paginator ~/ 2),
//                 Divider(height: 5.0),
//               ],
//             );
//           }),
//     );
//   }


//   void _onTapItem(BuildContext context, Post post) {

//   }
// }


//НИЖНЯЯ СТРОКА С ВРЕМЕНЕМ ДАТОЙ И ЗВЕЗДАМИ В LISTVIEW
// Widget get_subtitle(List<Post> posts, int position){
//   return 
//   Align(
//     alignment: AlignmentDirectional.centerStart,
//     child:
//     Column(
//       children: <Widget>[
//       Align(
//       alignment: AlignmentDirectional.centerStart,
//       child:
//         Text(
//           'Дата: ${posts[position].date_zd.toString().substring(5,10)}     Время: ${posts[position].time_zd.toString().substring(0,5)}',
//               style: TextStyle(fontSize: 12.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w500, color:  Color.fromRGBO(114, 103, 239, 1),
//               ),
//             ),
//           ),
//       Align(
//       alignment: AlignmentDirectional.centerStart,
//       child:
//         StarDisplay(value: posts[position].paginator ~/ 2),
//       ),
//       ],
//     ),
//   );
// }

  // Widget getPreviewData(AsyncSnapshot<List<Post>> snapshot){
  //   return snapshot.hasData
  //             ? ListViewPosts(posts: snapshot.data) // return the ListView widget
  //             : Center(child: CircularProgressIndicator());
  // }

  // Future<List<Post>> buildCountWidget() {
  //   return  fetchPosts(http.Client());
  // }

// ------------------------------ HTTP ЗАПОС---------
// --------------------------------------------------
// httpGet(String link) async{
//     try{
//       var response = await http.get('$link');
//       print("Статус ответа: ${response.statusCode}");
//       print("Тело ответа: ${response.body}");
//     } catch (error){
//       print('Ты ебловоз блять! А вот твоя ошибка: $error');
//     }
//   }









        // Container(
        //   margin: EdgeInsets.symmetric(vertical: 20.0),
        //   height: 100.0,
        //   child:
        //   FutureBuilder<List<RadioModel>>(
        // future: getRadioList(),
        // builder:
        //  (BuildContext context, AsyncSnapshot<List<RadioModel>> snapshot) {
        //   if (snapshot.hasData) 
        //   {
        //    return ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: snapshot.data.length,
        //       itemBuilder: (context, i) {
        //         RadioModel sampleData = snapshot.data[i];
        //         return 
        //         InkWell(
        //         onTap: () {
        //           if(i == snapshot.data.length - 1){
        //             Navigator.pushNamed(context, '/addMark');
        //           }
        //           setSelectedRadio(i+1);
        //           setState(() {
        //             snapshot.data.forEach((element) => element.isSelected = false);
        //             sampleData.isSelected = true;

        //           });
        //         },
        //         splashColor: Color.fromRGBO(114, 103, 239, 1),
        //         child: getCustomRadio(sampleData, snapshot.data.length),
        //         );
        //       }
        //     );
        //   }
        //   else 
        //     {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //   }
        //   ),
        //   ),