import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NotesTile extends StatefulWidget {
  const NotesTile(this.backgroundColor, this.content, this.id);

  final int backgroundColor;
  final String content;
  final int id;

  @override
  _NotesTileState createState() => _NotesTileState();
}

class _NotesTileState extends State<NotesTile> {
    var cliced = true;
    bool showSnack = false;
    int countLongPress = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      color: cliced ? Colors.white : Color.fromRGBO(200, 200, 200, 1),
      borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [ BoxShadow(
          color: Colors.black.withOpacity(0.07),
          blurRadius: 5.0, 
          spreadRadius: 0.5,
          offset: Offset(0.0, 0.0,),
        )
      ],
    ),
      child: new InkWell(
        onLongPress: (){  },
        onTap: () {  },
        child: Align(
          alignment: Alignment.topCenter,
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: Expanded(
              child: Text( widget.content,
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: cliced? Colors.black : Colors.black54,
                  fontSize: DesignTheme.size.determineFontSizeForContent(widget.content),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}