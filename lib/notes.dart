import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/rendering.dart';
import 'package:flushbar/flushbar.dart';

class Example01 extends StatefulWidget {
  @override
  _Example01State createState() => _Example01State();
}

class _Example01State extends State<Example01> {
  ScrollController scrollController;
  bool dialVisible = true;

                bool lastStatus = true;

              scrollListener() {
                if (isShrink != lastStatus) {
                  setState(() {
                    lastStatus = isShrink;
                  });
                }
              }

              bool get isShrink {
                return scrollController.hasClients &&
                    scrollController.offset > (200 - kToolbarHeight);
              }


  @override
    void initState(){
      super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
    }

  void setDialVisible(bool value) {
      setState(() {
        dialVisible = value;
        print("$value");
      });
    }

  // getGrid(){
  //   return new _Example01Tile(Colors.brown, 'Icons.map');
  // }
  @override
  Widget build(BuildContext context) {
      // DBNoteProvider.db.getAllNotes().then((note){
        return new Scaffold(

        body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned:true,
            // shape: ContinuousRectangleBorder(
            // borderRadius: BorderRadius.only(
            //     bottomRight: Radius.circular(100),
            //     // bottomRight: Radius.circular(30)
            //     ),
            // ),
            
            title: 
            // Text("text sample",
            //                     style: TextStyle(
            //                       color: isShrink ? Colors.black : Colors.black,
            //                       fontSize: 16.0,
            //                     )),
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: 
            Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: 
                TextFormField(
                        
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black54,
                          ),

                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            icon: Padding(
                              padding: EdgeInsets.only(left:15, right: 15),
                              child:
                              Icon(Icons.search),
                              ),
                            contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                            // fillColor: Color.fromRGBO(114, 103, 239, 1),
                            // focusColor: Color.fromRGBO(114, 103, 239, 1),
                            // hoverColor: Color.fromRGBO(114, 103, 239, 1),
                            labelText: 'Поиск по заметкам...',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black54,
                            ),

                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: Colors.black54,
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
              ),
          ),

            backgroundColor: isShrink ? Colors.white : Colors.transparent,
            automaticallyImplyLeading: false,
            // pinned: false,
            snap: false,
            floating: false,
            expandedHeight: 58.0,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text("FlexibleSpace title"),
              // background: Image.asset(
              //   'res/images/material_design_3.png',
              //   fit: BoxFit.fill,
              // ),
            ),
          ),
          // If the main content is a list, use SliverList instead.
          SliverFillRemaining(
            child: 
              Padding(
              padding: EdgeInsets.only(right: 20, left: 20,),
              child:
                FutureBuilder<List<Note>>(
                future: DBNoteProvider.db.getAllNotes(),
                builder:
                (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                if (snapshot.hasData) 
                  {
                    return StaggeredGridView.countBuilder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(4.0),
                      crossAxisCount: 4,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i){
                        return _Example01Tile(snapshot.data[i].color, snapshot.data[i].content, snapshot.data[i].id);
                      },
                      staggeredTileBuilder: (int i) => 
                        StaggeredTile.count(getGridWidth(snapshot.data[i].content), getGridHeigth(snapshot.data[i].content)));
                  }
                else 
                {
                  return Center(child: CircularProgressIndicator());
                }
                // }
                // else{
                //   return CircularProgressIndicator();
                // }
                }
              ),
            ),
          ),
        ],
      ),
      //         appBar: AppBar(
      //           automaticallyImplyLeading: false,
      //           backgroundColor: Colors.white,
      //           // title: const Text('Заметки'),
      //           actions: <Widget>[
      //             IconButton(
      //               icon: const Icon(
      //                 Icons.delete,
      //                 color: Color.fromRGBO(114, 103, 239, 1),
      //               ),
      //               tooltip: 'Show Snackbar',
      //               onPressed: () {
                      
      //               },
      //             ),
      //             IconButton(
      //               icon: const Icon(
      //                 Icons.close,
      //                 color: Color.fromRGBO(114, 103, 239, 1),
      //                 ),
      //               tooltip: 'Next page',
      //               onPressed: () {
      //       },
      //     ),
      //   ],
      // ),
        // body:
        // Padding(padding: EdgeInsets.only(top:105),
        // child:
        //   FutureBuilder<List<Note>>(
        //     future: DBNoteProvider.db.getAllNotes(),
        //     builder:
        //     (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        //     if (snapshot.hasData) 
        //       {
        //  return StaggeredGridView.countBuilder(
        //       padding: const EdgeInsets.all(4.0),
        //       crossAxisCount: 4,
        //       itemCount: snapshot.data.length,
        //       itemBuilder: (context, i){
        //          return _Example01Tile(snapshot.data[i].color, snapshot.data[i].content, i);
        //        },
        //       staggeredTileBuilder: (int i) => 
        //         StaggeredTile.count(getGridWidth(snapshot.data[i].content), getGridHeigth(snapshot.data[i].content)));
        //       // child: new StaggeredGridView.count(
        //       //   crossAxisCount: 4,
        //       //   staggeredTiles: _staggeredTiles,
        //       //   children: _tiles,
        //       //   mainAxisSpacing: 4.0,
        //       //   crossAxisSpacing: 4.0,
        //       //   padding: const EdgeInsets.all(4.0),
        //       // )            
        //     }
        //   else 
        //   {
        //     return Center(child: CircularProgressIndicator());
        //   }
        //     // }
        //     // else{
        //     //   return CircularProgressIndicator();
        //     // }
        //     }
        //   ),
        // ),

             bottomNavigationBar: CurvedNavigationBar(
              height: 50.0,
              backgroundColor: Colors.transparent,
              animationDuration: Duration(microseconds: 2500),
              items: <Widget>[
                Icon(Icons.list, size: 30, color: Colors.black54,),
                Icon(FontAwesome.sticky_note_o, size: 30, color: Colors.deepPurpleAccent,),
                Icon(Icons.add, size: 30, color: Colors.black54,),
                Icon(Icons.pie_chart_outlined, size: 30, color: Colors.black54,),
                Icon(FontAwesome.user_o, size: 30, color: Colors.black54,),
                // Icon(Icons.compare_arrows, size: 30, color: Colors.black,),
                // Icon(Icons.add, size: 30, color: Colors.black,),
                // Icon(Icons.list, size: 30, color: Colors.black,),
              ],
              index: 1,
              animationCurve: Curves.bounceInOut,
              onTap: (index) {
                if(index == 0){
                  Navigator.pushNamed(context, '/');
                }
                if(index == 1){
                  Navigator.pushNamed(context, '/notes');
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

            floatingActionButton:
            //  FloatingActionButton(
            //   onPressed: () {
            //     DBNoteProvider.db.addNoteInit().then((res){
            //       print(res);
            //     });
            //   },
            //   child: Icon(Icons.add),
            //   backgroundColor: Color.fromRGBO(114, 103, 239, 1),
            // ),
            SpeedDial(
              // both default to 16
              marginRight: 18,
              marginBottom: 20,
              
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(
                color: Colors.white,
                size: 22.0,
                ),
              // this is ignored if animatedIcon is non null
              // child: Icon(Icons.add),
              visible: dialVisible,
              // If true user is forced to close dial manually 
              // by tapping main button and overlay is not rendered.
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.0,
              onOpen: () => print('OPENING DIAL'),
              onClose: () => print('DIAL CLOSED'),
              tooltip: 'Speed Dial',
              heroTag: 'speed-dial-hero-tag',
              backgroundColor: Color.fromRGBO(114, 103, 239, 1),
              foregroundColor: Colors.black,
              elevation: 8.0,
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                  child: Icon(Icons.add),
                  backgroundColor: Color.fromRGBO(114, 103, 239, 1),
                  // label: '',
                  // labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    Navigator.pushNamed(context, '/note');
                  }
                ),
                SpeedDialChild(
                  child: Icon(Icons.keyboard_voice),
                  backgroundColor: Color.fromRGBO(114, 103, 239, 1),
                  // label: 'Third',
                  // labelStyle: TextStyle(fontSize: 18.0),
                  onTap: (){
                    DBNoteProvider.db.addNoteInit().then((y){
                      setState(() {});
                    });
                    //  setState(() {});
                    // Navigator.pushNamed(context, '/notes');
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.dashboard),
                  backgroundColor: Color.fromRGBO(114, 103, 239, 1),
                  // label: 'Third',
                  // labelStyle: TextStyle(fontSize: 18.0),
                  onTap: (){
                  Flushbar(
                    // title:  "Hey Ninja",
                    // shape: ContinuousRectangleBorder(
                    // borderRadius: BorderRadius.only(
                    //     bottomRight: Radius.circular(100),
                    //     // bottomRight: Radius.circular(30)
                    //     ),
                    // ),
                    backgroundColor: Color.fromRGBO(114, 103, 239, 1),
                    // margin: EdgeInsets.all(8),
                    // borderRadius: 8,
                    flushbarPosition: FlushbarPosition.TOP,
                    message:  "Чтоб удалить выбранные заметки нажмите на иконку в всплывшем окне",
                    mainButton: FlatButton(
                      onPressed: () {

                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      )
                    ),
                    // duration:  Duration(seconds: 3),              
                  )..show(context);
                  },
                ),
              ],
            ),
          );
      // });
  }
}
  int getGridHeigth(String content){
    var height = 1;
    var charCount = content.length;
    if (charCount > 110 ) { height = 2; }
    else if (charCount > 80) {  height = 2;  }
    else if (charCount > 50) {  height = 1;  }
    else if (charCount > 20) {  height = 1;  }
    return height;
  }
  int getGridWidth(String content){
    var width = 1;
    var charCount = content.length;
    if (charCount > 15 ) { width = 2; }
    else if (charCount > 80) {  width = 2;  }
    else if (charCount > 50) {  width = 1;  }
    else if (charCount > 20) {  width = 1;  }
    return width;
  }

  double _determineFontSizeForContent(content) {
    int charCount = content.length ;
    double fontSize = 20 ;
    if (charCount > 150 ) { fontSize = 12; }
    else if (charCount > 80) {  fontSize = 14;  }
    else if (charCount > 50) {  fontSize = 16;  }
    else if (charCount > 20) {  fontSize = 18;  }
    return fontSize;
  }

class _Example01Tile extends StatefulWidget {
  const _Example01Tile(this.backgroundColor, this.content, this.id);

  final int backgroundColor;
  final String content;
  final int id;

  @override
  __Example01TileState createState() => __Example01TileState();
}

class __Example01TileState extends State<_Example01Tile> {
    // var bc = widget.backgroundColor;
    var cliced = true;
    bool showSnack = false;
    int countLongPress = 0;

    void setClick() {
      setState(() {
        cliced = cliced? false : true;
      });
    }

    void setFalseClick(){
      setState(() {
        cliced = true;
      });
    }

  @override
  Widget build(BuildContext context) {
    return new Card(
      // color: cliced ? Colors.white : Color.fromRGBO(114, 103, 239, 1),
      
      color: cliced ? Colors.white : Color.fromRGBO(200, 200, 200, 1),
      child: new InkWell(
        onLongPress: (){
          DBNoteProvider.db.updateColor(widget.id).then((res){
            DBNoteProvider.db.getArchivedCount().then((archivedCount){
              print("Количество удаленных в бд --->"+archivedCount.toString());
              var color = res;
            if(color == 0){
              countLongPress = countLongPress - 1;
              showSnack = false;
              print("Теперь я не удалюсь $countLongPress");
            }
            else{
              countLongPress = countLongPress + 1;
              showSnack = true;
              print("Я удалюсь $countLongPress");
            }

            if(showSnack && archivedCount == 1){
              showSnack = false;
              Flushbar(
                    // title:  "Hey Ninja",
                    backgroundColor: Color.fromRGBO(114, 103, 239, 1),
                    // margin: EdgeInsets.all(8),
                    // borderRadius: 8,
                    flushbarPosition: FlushbarPosition.TOP,
                    message:  "Если вы хотите удалить выбранные заметки нажмите на иконку в всплывшем окне",
                    mainButton: FlatButton(
                      onPressed: () {
                        DBNoteProvider.db.deleteCheckedNotes().then((res){
                          print("Кол-во удаленных --->"+res.toString());
                          Navigator.pushNamed(context, '/notes');
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      )
                    ),
                    // duration:  Duration(seconds: 3),              
                  )..onStatusChanged = (FlushbarStatus status) {
                switch (status) {
                  case FlushbarStatus.SHOWING:
                    {
                      break;
                    }
                  case FlushbarStatus.IS_APPEARING:
                    {
                      break;
                    }
                  case FlushbarStatus.IS_HIDING:
                    {
                      break;
                    }
                  case FlushbarStatus.DISMISSED:
                    {
                      DBNoteProvider.db.recoverNotes().then((s){
                        print("Меня ебанули $s");
                      });
                      break;
                    }
                }
              }..show(context);
            }
            });
            // print(" Пробовал -->"+widget.id.toString()+" Получил ---> "+res.toString()+" На фиалку");
          });
          setClick();
        },
        onTap: () {
          setFalseClick();
          DBNoteProvider.db.updateColorFalse(widget.id, 0).then((res){
            print(" Пробовал -->"+widget.id.toString()+" Получил ---> "+res.toString()+" На белый");
          });
        },
        child: new Align(
          alignment: Alignment.topCenter,
          child: new Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.content,
              // widget.content,
              style: TextStyle(
                color: cliced? Colors.black : Colors.black54,
                fontSize: _determineFontSizeForContent(widget.content),
              ),
            ),
            // child: new Icon(
            //   iconData,
            //   color: Colors.white,
            // ),
          ),
        ),
      ),
    );
  }
}