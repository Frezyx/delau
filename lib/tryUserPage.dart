import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/widget/roundIcon.dart';
import 'package:delau/widgets_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;

import 'models/global.dart';

class UPN extends StatefulWidget {

  @override
  _UPNState createState() => _UPNState();
}

class _UPNState extends State<UPN> {

  bool registration = false;
  String name ="";
  String surname = "";
  int countAdd = 0;
  int countDone = 0;
  int rating = 0;

  final Shader linearGradient = LinearGradient(
  colors: <Color>[Color.fromRGBO(114, 103, 239, 1),  
                  Color.fromRGBO(162, 122, 246, 1)],
  ).createShader(Rect.fromLTWH(100.0, 0.0, 200.0, 50.0));

  setData(ClientUser res){
    setState(() {
      surname = res.surname;
      name = res.name;
      countAdd = res.countAdd;
      countDone = res.countDone;
      rating = res.rating;
    });
  }

  @override
  void initState() {
    super.initState();

    DBUserProvider.dbc.getClientUser(1).then((res){
      registration = (res.reg == 1);
        setData(res);
      print(registration);
    });
  }
  Future<String> httpGetTry(String link) async{
    String responses;
    try{
      var response = await http.get('$link');
      print("Статус ответа: ${response.statusCode}");
      print("Тело ответа: ${response.body}");
      responses = response.body;
    } catch (error){
      print('Ты ебловоз блять! А вот твоя ошибка: $error');
    }
    return responses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  constraints: BoxConstraints.expand(height: 300),
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [ Color.fromRGBO(162, 122, 246, 1), Color.fromRGBO(114, 103, 239, 1),],

                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.0,1.0],
                      tileMode: TileMode.clamp
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 120,
                          child: Image.asset('assets/ufo.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(registration ? name.isEmpty ? "..." : name : "Неопознанный", 
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0,
                                  fontWeight: FontWeight.w900, color: Colors.white,
                                )
                              ),
                              Text(registration ? surname.isEmpty ? "..." : surname : "Пользователь",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0,
                                  fontWeight: FontWeight.w900, color: Colors.white,
                                )
                              ),
                              registration? getSettingsIcon() : SizedBox(height: 0,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:220),
                  constraints: BoxConstraints.expand(height:200),
                  child: new FutureBuilder<List<Task>>(
                    future: DBProvider.db.getAllTasks(),
                    builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting: return new Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError)
                              return new Text('Error: ${snapshot.error}');
                          else
                          return ListView.builder(
                            
                            padding: EdgeInsets.only(left: 40),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              Task item = snapshot.data[index];
                              return getTaskCard(item);
                            }
                          );
                      }
                      }
                    ),
                ),
              ],
            ),
    Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only( bottom: 5, top: 5),
      height: 170,
      width: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

            Padding(
                    padding: EdgeInsets.all(5.0),
                    child:
             Row(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
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
                  child:
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                ),
              ), 
                      Padding(
            padding: EdgeInsets.only( left: 10.0),
            child:
            Text("Создано задач: ${countAdd.toString()}",
             style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black)),
                      ),
            ],
            ),
            ),

          Padding(
            padding: EdgeInsets.all(5.0),
            child:
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
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
                  child:
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      FontAwesome.check,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
                      Padding(
            padding: EdgeInsets.only( left: 10.0),
            child:
            Text("Выполненно задач: ${countDone.toString()}", style: 
            TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.black)),
                      ),
            ],
            ),
          ),
          
        Padding(
          padding: EdgeInsets.all(5.0),
          child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                  child:
                  Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    FontAwesome.thumbs_up,
                    size: 20,
                    color: Colors.white,
                    ),
                ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only( left: 10.0),
                child:
                Text(
                  "Рейтинг: ${rating.toString()}",
                   style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontFamily: "Exo 2",fontSize: 18.0,
                      fontWeight: FontWeight.w300, color: Colors.black)
                    ),
                    
                  ),
            ],
            ),
        ),
        ],
      ),
    ),
    registration ? SizedBox(height: 10) : getLoginButtonCard(context, linearGradient),
          ],
        ),
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
        ],
        index: 4,
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
        }
      ),
    );
  }

  Widget getLoginButtonCard(context, linearGradient){
  return  
  Container(
      padding: EdgeInsets.all(10),
      height: 118,
      width: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),

      child: registration ? SizedBox(height:10): getCardInside(),

      );
    }

    Widget getCardInside(){
      return   Column(
    children: <Widget>[
      Padding(
    padding: EdgeInsets.only(right: 0.0, left: 0.0),
    child:
    Container(
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
                          ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.0,1.0],
                        tileMode: TileMode.clamp
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 0.0, minHeight: 40.0),
          alignment: Alignment.center,
          child: Text('n', textAlign: TextAlign.center, 
          style: TextStyle(fontFamily: "Ubuntu",fontSize: 24.0, color: Colors.white),),
          ),
        ),
      ),
      ),
    ),
    Padding(
        padding: EdgeInsets.only(right: 0.0, left: 0.0),
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
      padding: const EdgeInsets.all(0.0),
        child: Container(
          constraints: const BoxConstraints(minWidth: 0.0, minHeight: 40.0),
          alignment: Alignment.center,
          child: Text('Войти', textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0, fontWeight: FontWeight.w900,
          foreground: Paint()..shader = linearGradient,
          ),),
          ),
      ),
    ),

        ]
        );
    }

    Widget getTaskCard(Task task) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 20, bottom: 30, top: 30),
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              RoundIcon(item: task,),
              Padding(
                  child: Text(
                  task.title.length > 20 ? task.title.substring(0, 20)+"..." : task.title,
                  style: jobCardTitileStyleBlue,
                ), padding: EdgeInsets.only(left: 5),
              )
            ],
          ),
          Text(task.description.length > 20 ? task.description.substring(0, 20)+"..." : task.description,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StarDisplayWidget(value: task.priority ~/ 2),
          Padding(
            padding: EdgeInsets.only(bottom: 2, left: 2, top: 2),
            child:
            Text('Дата: ${task.date.substring(5,10)}     Время: ${task.time.substring(10,15)}',
                style: TextStyle(fontSize: 12.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w400, color:  Color.fromRGBO(114, 103, 239, 1),
              ),
            ),
          ),
          ],
          ),
        ],
      ),
    );
  }

  Widget getSettingsIcon(){
                                return  IconButton(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.all(0),
                                iconSize: 24,
                                icon: Icon(Icons.settings),
                                color: Colors.white,
                                splashColor: Colors.white,
                                onPressed: (){
                                  Navigator.pushNamed(context, '/update');
                                },
                              );
  }

}
