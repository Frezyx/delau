import 'package:delau/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/widget/postItem.dart';

class PostPage extends StatefulWidget {
  String _id;

  PostPage({String id}): _id = id;

  @override
  _PostPageState createState() => _PostPageState(_id);
}

class _PostPageState extends State<PostPage> {
  String id;

  _PostPageState(this.id);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
           appBar: AppBar(

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
// РАБОТАЕМ ТУТ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      body: FutureBuilder<List<Client>>(
        future: DBProvider.db.getClientInList(int.parse(id)),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) 
          {
            return ListViewPosts(item: snapshot.data);
          }
        },
      ),

      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   child: Container(
      //     height: 50.0,
      //     child: Row(
      //       children: <Widget>[
      //         FlatButton(
      //           color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
      //           padding: EdgeInsets.only( left: 0.0, top: 15, bottom: 15, ),
      //           onPressed: () {

      //           },
      //           child: 
      //           Row(
      //             mainAxisSize: MainAxisSize.max,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: <Widget>[
      //               // Icon(Icons.calendar_today,size: 20.0,),
      //               Text(
      //                   "Сегодня",
      //                   style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
      //                 ),
      //             ],

      //           ),
      //         ),

      //         FlatButton(
      //           color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
      //           padding: EdgeInsets.only( left: 0.0, top: 15, bottom: 15),
      //           onPressed: () {
      //             /*...*/
      //           },
      //           child: 
      //           Row(
      //             mainAxisSize: MainAxisSize.max,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: <Widget>[
      //               // Icon(Icons.perm_contact_calendar,size: 20.0,),
      //               Text(
      //                   "Завтра",
      //                   style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
      //                 ),
      //             ],

      //           ),
      //         ),

      //         FlatButton(
      //           color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
      //           padding: EdgeInsets.only( left: 60.0, top: 15, bottom: 15),
      //           onPressed: () {
      //             /*...*/
      //           },
      //           child: 
      //           Row(
      //             mainAxisSize: MainAxisSize.max,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: <Widget>[
      //               // Icon(Icons.perm_contact_calendar,size: 20.0,),
      //               Text(
      //                   "Календарь",
      //                   style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
      //                 ),
      //             ],

      //           ),
      //         ),

      //                       FlatButton(
      //           color: Colors.transparent, textColor: Color.fromRGBO(114, 103, 239, 1),
      //           padding: EdgeInsets.only(left: 0.0, top: 15, bottom: 15),
      //           onPressed: () {
      //             /*...*/
      //           },
      //           child: Text(
      //             "Поиск",
      //             style: TextStyle(fontSize: 13.0, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
      //           ),
      //         ),
              
              
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {Navigator.pushNamed(context, '/second/123');},
      //   child: Icon(Icons.add),
      //   backgroundColor: Color.fromRGBO(114, 103, 239, 1),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}