import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:flutter/material.dart';

class NotesListBloc extends ChangeNotifier {
  bool _isAnNoteSelected = false;
  int _selectedCount = 0;
  int _addedNotesCount = 0;

  int get addedNotesCount => _addedNotesCount;

  bool get isAnNoteSelected => _isAnNoteSelected;

  set isAnNoteSelected(bool val) {
    _isAnNoteSelected = val;
    notifyListeners();
  }

  List _notes = [];

  List get notes => _notes;

  set notes(List val) {
    _notes = val;
    notifyListeners();
  }

  void addNote(Note note) {
    _notes.add(note);
    _addedNotesCount += 1;
    notifyListeners();
  }

  List<int> unSelectAllNotes() {
    List<int> idList = [];
    for (var i = 0; i < _notes.length; i++) {
      if (_notes[i].isSelected) {
        idList.add(_notes[i].id);
        _notes[i].isSelected = false;
        _selectedCount--;
      }
    }
    DBNoteProvider.db.deleteCheckedNotes(idList);
    _isAnNoteSelected = false;
    notifyListeners();
    return idList;
  }

  void selectNote(int index) {
    _notes[index].isSelected = !_notes[index].isSelected;
    _selectedCount =
        !_notes[index].isSelected ? _selectedCount - 1 : _selectedCount + 1;
    _isAnNoteSelected = _selectedCount >= 1;

    notifyListeners();
  }

  bool isItemSelected(int index) {
    return _notes[index].isSelected;
  }
}
