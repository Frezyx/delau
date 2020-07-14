import 'package:delau/blocs/notesListBloc.dart';
import 'package:delau/widget/alerts/addMarker.dart';
import 'package:delau/widget/alerts/addNote.dart';
import 'package:delau/widget/alerts/addTask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

getTaskCreateAlert(BuildContext context, int index, DateTime date) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            clipBehavior: Clip.hardEdge,
            insetAnimationDuration: const Duration(milliseconds: 300),
            child: AddTaskAlert(
              returnPageIndex: index,
              date: date,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))));
      });
}

getNoteCreateAlert(BuildContext context, int index, DateTime date) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            clipBehavior: Clip.hardEdge,
            insetAnimationDuration: const Duration(milliseconds: 300),
            child: ChangeNotifierProvider<NotesListBloc>(
              create: (_) => NotesListBloc(),
              child: AddNoteAlert(),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))));
      });
}

getMarkerCreateAlert(BuildContext context, int index, DateTime date) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            clipBehavior: Clip.hardEdge,
            insetAnimationDuration: const Duration(milliseconds: 300),
            child: AddMarkerAlert(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))));
      });
}
