import 'package:delau/utils/iconList.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconDrag extends StatefulWidget{
  @override
  _IconDragState createState() => _IconDragState();
}

class _IconDragState extends State<IconDrag> {

  getCustomRadio(int i,){
    Widget returnWidget; 
    if(i % 5 == 0){
      returnWidget =  new
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

  InkWell(
    onTap:() {
       Navigator.pushNamed(context, '/addMark/${i}/${iconsMaterial[i]}');
    },
    splashColor: Color.fromRGBO(114, 103, 239, 1),
    child:
    Container(
      margin: new EdgeInsets.all(12.0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Icon(
                MdiIcons.fromString(iconsMaterial[i]),
                color: Color.fromRGBO(114, 103, 239, 1)
                ),
            ),
            decoration: new BoxDecoration(
              color: Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: Color.fromRGBO(114, 103, 239, 1)),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    ),
  ),

  InkWell(
    onTap:() {
       
    },
    splashColor: Color.fromRGBO(114, 103, 239, 1),
    child:
    Container(
      margin: new EdgeInsets.all(12.0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Icon(
                MdiIcons.fromString(iconsMaterial[i+1]),
                color: Color.fromRGBO(114, 103, 239, 1)
                ),
            ),
            decoration: new BoxDecoration(
              color: Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: Color.fromRGBO(114, 103, 239, 1)),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    ),
  ),

  InkWell(
    onTap:() {
       Navigator.pushNamed(context, '/addMark/${i+2}/${iconsMaterial[i+2]}');
    },
    splashColor: Color.fromRGBO(114, 103, 239, 1),
    child:
    Container(
      margin: new EdgeInsets.all(12.0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Icon(
                MdiIcons.fromString(iconsMaterial[i+2]),
                color: Color.fromRGBO(114, 103, 239, 1)
                ),
            ),
            decoration: new BoxDecoration(
              color: Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: Color.fromRGBO(114, 103, 239, 1)),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    ),
  ),

  InkWell(
    onTap:() {
       Navigator.pushNamed(context, '/addMark/${i+3}/${iconsMaterial[i+3]}');
    },
    splashColor: Color.fromRGBO(114, 103, 239, 1),
    child:
    Container(
      margin: new EdgeInsets.all(12.0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Icon(
                MdiIcons.fromString(iconsMaterial[i+3]),
                color: Color.fromRGBO(114, 103, 239, 1)
                ),
            ),
            decoration: new BoxDecoration(
              color: Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: Color.fromRGBO(114, 103, 239, 1)),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    ),
  ),    

  InkWell(
    onTap:() {
      Navigator.pushNamed(context, '/addMark/${i+4}/${iconsMaterial[i+4]}');
    },
    splashColor: Color.fromRGBO(114, 103, 239, 1),
    child:
    Container(
      margin: new EdgeInsets.all(12.0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Icon(
                MdiIcons.fromString(iconsMaterial[i+4]),
                color: Color.fromRGBO(114, 103, 239, 1)
                ),
            ),
            decoration: new BoxDecoration(
              color: Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: Color.fromRGBO(114, 103, 239, 1)),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    ),
  ),
    
      ],);
    }
    else{
      returnWidget = new SizedBox(height: 0.0);
    }
    return returnWidget;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(
          child:
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: iconsMaterial.length,
              itemBuilder: (context, i) {
                return 
                 getCustomRadio(i);
              }
            ),
          ),
    );
  }
}

