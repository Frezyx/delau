import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';


class ListViewPosts extends StatefulWidget {

  final List<Task> item;


  ListViewPosts({Key key, this.item}) : super(key: key);

  @override
  _ListViewPostsState createState() => _ListViewPostsState();
}

class _ListViewPostsState extends State<ListViewPosts> {
   List<String> backgrounds =[
    "assets/background/learning.jpg",
    "assets/background/working.jpg",
    "assets/background/sport.jpg",
    "assets/background/meet.jpg",
    "assets/background/shop.jpg",
    "assets/postBackground.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return 
    Container(
            decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("${backgrounds[widget.item[0].marker <= 5 ? widget.item[0].marker : 5]}"), fit: BoxFit.cover)),
                child:
                Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0, top: MediaQuery.of(context).size.height-550, bottom: MediaQuery.of(context).size.height-550),
                  child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
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
      child:
       Padding(
          padding: EdgeInsets.all(10),
          child:
       Column(
          mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text('${widget.item[0].title}',
                 textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.w500,),
                  ),
                 Text('${widget.item[0].description}',
                 textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.w200,),
                  ),
                StarDisplay(value: widget.item[0].priority ~/ 2),
                Text(
                  'Дата: ${widget.item[0].date.toString().substring(5,10)}      Время: ${widget.item[0].time.toString().substring(10,15)}',
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
    ),
    Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                      onPressed: () {
                          Navigator.pushNamed(context, '/updateTask/${widget.item[0].id}');
                        },
                        splashColor: Colors.transparent,  
                        highlightColor: Colors.transparent,
                        
                        child: Text(
                          "Редактировать",
                          style: TextStyle(
                            color:  Color.fromRGBO(114, 103, 239, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            ),
                        ),
                      ),
                      FlatButton(
                      onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        splashColor: Colors.transparent,  
                        highlightColor: Colors.transparent,
                        
                        child: Text(
                          "Назад",
                          style: TextStyle(
                            color:  Color.fromRGBO(114, 103, 239, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
                  ],
                ),
              )
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