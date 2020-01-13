import 'package:flutter/material.dart';

import 'main.dart';


//КАРТОЧКА НА ГЛАВНОЙ СТРАНИЦЕ
Widget getCardInfo(int i, List<IconData> i_add, List<String>slider_titles){
    return Row(
      children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.only(bottom: 65.0, left: 25.0),
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
              padding: EdgeInsets.only(top: 28, left: 25.0),
              child:  
              Text(slider_titles[i-1], 
                style: TextStyle(
                fontFamily: "Exo 2",
                fontSize: 30.0, 
                fontWeight: FontWeight.w100, 
                color: Colors.black),
                ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 2, left: 15),
                child:
                  Text("Просрочено:",
                    style: TextStyle(
                    fontFamily: "Exo 2",
                    fontSize: 14.0, 
                    fontWeight: FontWeight.w300, 
                    color: Color.fromRGBO(158, 158, 158, 1)),
                  ),
                ),
            Padding(
                padding: EdgeInsets.only(top: 0, left: 15),
                child:
                  Text("Выполненно:",
                    style: TextStyle(
                    fontFamily: "Exo 2",
                    fontSize: 14.0, 
                    fontWeight: FontWeight.w300, 
                    color: Color.fromRGBO(158, 158, 158, 1)),
                  ),
                ),
            Padding(
                padding: EdgeInsets.only(top: 0, left: 15),
                child:  Text("Сейчас:",
                    style: TextStyle(
                    fontFamily: "Exo 2",
                    fontSize: 14.0, 
                    fontWeight: FontWeight.w300, 
                    color: Color.fromRGBO(158, 158, 158, 1)),
                  ),
            ),
        ],
        ),
      ],
    );
  }

//НИЖНЯЯ СТРОКА С ВРЕМЕНЕМ ДАТОЙ И ЗВЕЗДАМИ В LISTVIEW
Widget get_subtitle(List<Post> posts, int position){
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
          'Дата: ${posts[position].date_zd.toString().substring(5,10)}     Время: ${posts[position].time_zd.toString().substring(0,5)}',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w500, color:  Color.fromRGBO(114, 103, 239, 1),
              ),
            ),
          ),
      Align(
      alignment: AlignmentDirectional.centerStart,
      child:
        StarDisplay(value: posts[position].paginator ~/ 2),
      ),
      ],
    ),
  );
}