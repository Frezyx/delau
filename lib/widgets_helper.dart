import 'package:flutter/material.dart';

import 'main.dart';
import 'models/dbModels.dart';

class StarDisplayWidget extends StatelessWidget {
  final int value;
  const StarDisplayWidget({Key key, this.value = 0})
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

Widget getCardInfo(int i, List<IconData> i_add, List<String>slider_titles, countTasks){
    return Row(
      children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.0, left: 15.0),
            child:  new FloatingActionButton(
              heroTag: "btn_inslider_number"+i.toString(),
              child:
              new Container(
                decoration:  new BoxDecoration(
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
                  child: Icon(i_add[i-1],size: 30,),
                ),
              ), 
                onPressed: () => {

                },
              ),
          ),
        ),
        Column(
            children: <Widget>[
              Padding(
              padding: EdgeInsets.only(top: 15, left: 25.0),
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
                  Text("Задач: ${countTasks}",
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

Widget get_subtitle_of_SQLI(Task item){
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