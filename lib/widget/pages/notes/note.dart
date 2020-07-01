import 'package:delau/blocs/notesListBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class NotesTile extends StatefulWidget {
  const NotesTile(this.backgroundColor, this.content, this.id, this.index);

  final int backgroundColor;
  final String content;
  final int id;
  final int index;

  @override
  _NotesTileState createState() => _NotesTileState();
}

class _NotesTileState extends State<NotesTile> {
    var cliced = true;
    bool showSnack = false;
    int countLongPress = 0;

  @override
  Widget build(BuildContext context) {
    
    final noteListBloc = Provider.of<NotesListBloc>(context);

    return Card(
      shadowColor: noteListBloc.isItemSelected(widget.index)? Colors.red.withOpacity(0.35) : Colors.black.withOpacity(0.2),
      elevation: 5,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10),),
        side: noteListBloc.isItemSelected(widget.index)? BorderSide(width: 1, color: Colors.red) : BorderSide(width: 0, color: Colors.white),
      ),
      color: Colors.white,
      child: InkWell(
        highlightColor: Colors.white,
        hoverColor: Colors.red,
        focusColor: Colors.red,
        splashColor: Colors.red,
        onLongPress: (){ 
          noteListBloc.selectNote(widget.index);
        },
        onTap: () { 
          noteListBloc.isAnNoteSelected? noteListBloc.selectNote(widget.index): null;
         },
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child:
        Align(
          alignment: Alignment.topCenter,
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: Expanded(
              child: Text( 
                widget.content,
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