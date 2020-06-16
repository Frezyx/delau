import 'package:flutter/material.dart';

class OnWork extends StatefulWidget {
  String _id;

  OnWork({String id}): _id = id;

  @override
  __OnWorkState createState() => __OnWorkState(_id);
}

class __OnWorkState extends State<OnWork> {
    String id;

  __OnWorkState(this.id);


  String imgSrc = "assets/ufo.png";
    final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(114, 103, 239, 1),  
                    Color.fromRGBO(162, 122, 246, 1)],
  ).createShader(Rect.fromLTWH(100.0, 0.0, 200.0, 50.0));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          Container(
                height: 200,
                child: Image.asset('assets/pageComing.png'),
          ),
          SizedBox(height: 20,),
          Text(
            "Виджет в разработке",
            style: TextStyle(
              fontSize: 22.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
            ), 
          ),
          Padding(
    padding: EdgeInsets.only(right: 80.0, left: 80.0),
    child:
Container(
  child:
  RaisedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/postPage/${id}');
   },
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  padding: const EdgeInsets.all(0.0),
  child: Ink(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
                      colors: [
                      Color.fromRGBO(114, 103, 239, 1),
                      Color.fromRGBO(162, 122, 246, 1),
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
      child: Text('Незад', textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.white),),
      ),
    ),
  ),
  ),
),
      ]
    );
  }
}