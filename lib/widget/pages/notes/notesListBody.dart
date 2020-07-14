import 'package:delau/blocs/notesListBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/widget/pages/notes/note.dart';
import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class NotesListBody extends StatelessWidget {
  const NotesListBody({
    Key key,
    @required this.isSaerching,
    @required this.searchText,
  }) : super(key: key);

  final bool isSaerching;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    final noteListBloc = Provider.of<NotesListBloc>(context);
    noteListBloc.loadNotes();

    return Padding(
      padding: const EdgeInsets.only(top: 170.0),
      child: Container(
        height: 500,
        child: Padding(
          padding: EdgeInsets.only(
            right: 15,
            left: 15,
          ),
          child: noteListBloc.isEventsLoad
              ? buildBody(noteListBloc)
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  buildBody(noteListBloc) {
    return AnimationLimiter(
        child: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.all(2.0),
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            crossAxisCount: 4,
            itemCount: noteListBloc.notes.length,
            itemBuilder: (context, i) {
              return AnimationConfiguration.staggeredGrid(
                  position: i,
                  duration: const Duration(milliseconds: 475),
                  columnCount: 2,
                  child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                          child: NotesTile(
                              noteListBloc.notes[i].color,
                              noteListBloc.notes[i].content,
                              noteListBloc.notes[i].id,
                              i))));
            },
            staggeredTileBuilder: (int i) => StaggeredTile.count(
                DesignTheme.size.getGridWidth(noteListBloc.notes[i].content),
                DesignTheme.size
                    .getGridHeigth(noteListBloc.notes[i].content))));
  }
}
