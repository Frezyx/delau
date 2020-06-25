import 'package:delau/design/theme.dart';
import 'package:delau/widget/notes/note.dart';
import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/rendering.dart';


class NotesListBody extends StatelessWidget {
  const NotesListBody({
    Key key,
    @required this.isSaerching,
    @required this.searchText,
    @required this.scrollController,
  }) : super(key: key);

  final bool isSaerching;
  final String searchText;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 170.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[

          // Padding(
          //   padding: EdgeInsets.only(left: 20, bottom: 5, top: 10),
          //   child: Text("Результаты поиска:", style: DesignTheme.listItemLabel ),),

          Flexible(
            child:Padding(
              padding: EdgeInsets.only(right: 15, left: 15,),
              child: FutureBuilder<List<Note>>(
                future: isSaerching ? DBNoteProvider.db.getAllNotesSearch(searchText) : DBNoteProvider.db.getAllNotes(),
                builder:
                (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                if (snapshot.hasData) 
                  {
                    return StaggeredGridView.countBuilder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(2.0),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 4,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i){
                        return NotesTile(snapshot.data[i].color, snapshot.data[i].content, snapshot.data[i].id);
                      },
                      staggeredTileBuilder: (int i) => 
                        StaggeredTile.count(
                          DesignTheme.size.getGridWidth(snapshot.data[i].content), 
                          DesignTheme.size.getGridHeigth(snapshot.data[i].content)
                        )
                      );
                  }
                else { return Center(child: CircularProgressIndicator()); }
                }
              ),
            ),
          ),
        ]
      ),
    );
  }
}