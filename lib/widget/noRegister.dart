import 'package:flutter/material.dart';

class NoRegister extends StatefulWidget {
  // const _Example01Tile(this.backgroundColor, this.content, this.id);

  // final int backgroundColor;
  // final String content;
  // final int id;

  @override
  __NoRegisterState createState() => __NoRegisterState();
}

class __NoRegisterState extends State<NoRegister> {
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
                child: Image.asset('assets/ufo.png'),
          ),
          SizedBox(height: 20,),
          Text(
            "Вы ещё не зарегистрированны",
            style: TextStyle(
              fontSize: 22.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              // color: Color.fromRGBO(114, 103, 239, 1),
            ), 
          ),
          // SizedBox(height: 20,),
          Padding(
    padding: EdgeInsets.only(right: 40.0, left: 40.0),
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
                      Color.fromRGBO(114, 103, 239, 1),
                      Color.fromRGBO(162, 122, 246, 1),
                      
                      // Color.fromRGBO(81, 20, 219, 1),
                      // Color.fromRGBO(31, 248, 169, 1),
                      ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    child: Container(
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 40.0), // min sizes for Material buttons
      alignment: Alignment.center,
      child: Text('Зарегистрироваться', textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0, fontWeight: FontWeight.w900, color: Colors.white),),
      ),
    ),
  ),
  ),
),
Padding(
    padding: EdgeInsets.only(right: 40.0, left: 40.0),
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
  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  padding: const EdgeInsets.all(0.0),
    child: Container(
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 40.0), // min sizes for Material buttons
      alignment: Alignment.center,
      child: Text('Войти', textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic, fontFamily: "Exo 2",fontSize: 24.0, fontWeight: FontWeight.w900,
      //  color: Color.fromRGBO(114, 103, 239, 1)
      foreground: Paint()..shader = linearGradient,
       ),),
      ),
  ),
),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("$imgSrc"), fit: BoxFit.cover)),
            //       // child:Container(
            //       //   ),
            //       ),
      ]
    );
  }
}