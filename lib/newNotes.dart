// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import 'models/dbModels.dart';

// class StaggeredGridPage extends StatefulWidget {
//   final notesViewType;
//   const StaggeredGridPage({Key key, this.notesViewType}) : super(key: key);
//   @override
//   _StaggeredGridPageState createState() => _StaggeredGridPageState();
// }

// class _StaggeredGridPageState extends State<StaggeredGridPage> {

//   var  noteDB = NotesDBHandler();
//   List<Map<String, dynamic>> _allNotesInQueryResult = [];

// @override
//   void initState() {
//     super.initState();

//   }

// @override void setState(fn) {
//     super.setState(fn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     GlobalKey _stagKey = GlobalKey();
//     if(CentralStation.updateNeeded) {  retrieveAllNotesFromDatabase();  }
//     return Container(child: Padding(padding:  _paddingForView(context) , child:
//       new StaggeredGridView.count(key: _stagKey,
//         crossAxisSpacing: 6, mainAxisSpacing: 6,
//         children: List.generate(_allNotesInQueryResult.length, (i){ 
//            return _tileGenerator(i); }), staggeredTiles: _tilesForView(), crossAxisCount: null ,
//           ),
//         )
//       );
//   }

//  List<StaggeredTile> _tilesForView() { // Создание шахматного представления 
//   return List.generate(_allNotesInQueryResult.length,(index){ return StaggeredTile.fit( 1 ); }
//   ) ;
// }

// EdgeInsets _paddingForView(BuildContext context){
//   double width = MediaQuery.of(context).size.width;
//   double padding ;
//   double top_bottom = 8;
//   if (width > 500) {
//     padding = ( width ) * 0.05 ; // 5% ширины с двух сторон
//   } else {
//     padding = 8;
//   }
//   return EdgeInsets.only(left: padding, right: padding, top: top_bottom, bottom: top_bottom);
// }


//  MyStaggeredTile _tileGenerator(int i){
//  return MyStaggeredTile(  
   
//    Note(
//       _allNotesInQueryResult[i]["id"],
//       _allNotesInQueryResult[i]["title"] == null ? "" : utf8.decode(_allNotesInQueryResult[i]
//          ["title"]),
//      DateTime.fromMillisecondsSinceEpoch(_allNotesInQueryResult[i]["date_created"] * 1000),
//    ),
//   );

//   }

//   void retrieveAllNotesFromDatabase() {
//     var _testData = noteDB.testSelect();
//     _testData.then((value){
//         setState(() {
//           this._allNotesInQueryResult = value;
//           CentralStation.updateNeeded = false;
//         });
//     });
//   }
// }