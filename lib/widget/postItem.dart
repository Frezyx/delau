import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';


class ListViewPosts extends StatelessWidget {

  final List<Client> item;

   List<String> backgrounds =[
    "assets/background/learning.jpg",
    "assets/background/working.jpg",
    "assets/background/sport.jpg",
    "assets/background/meet.jpg",
    "assets/background/shop.jpg",
    "assets/postBackground.jpg",
  ];
 
  ListViewPosts({Key key, this.item}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return 
    Container(
            decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("${backgrounds[item[0].marker]}"), fit: BoxFit.cover)),
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
                 Text('${item[0].title}', style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.w500,),
                  ),
                 Text('${item[0].description}', style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.w200,),
                  ),
                StarDisplay(value: item[0].priority ~/ 2),
                Text(
                  'Дата: ${item[0].date.toString().substring(5,10)}      Время: ${item[0].time.toString().substring(10,15)}',
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