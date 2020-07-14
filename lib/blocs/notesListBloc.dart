import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:flutter/material.dart';

class NotesListBloc extends ChangeNotifier {
  bool _isAnNoteSelected = false;
  int _selectedCount = 0;

  bool get isAnNoteSelected => _isAnNoteSelected;

  set isAnNoteSelected(bool val) {
    _isAnNoteSelected = val;
    notifyListeners();
  }

  String _searchText = "";
  String get searchText => _searchText;
  set searchText(String val) {
    _searchText = val;
    notifyListeners();
  }

  int _notesCount = 0;
  int get notesCount => _notesCount;
  set notesCount(int val) {
    _notesCount = val;
    notifyListeners();
  }

  int _nowCreatedNoteId = 0;
  int get nowCreatedNoteId => _nowCreatedNoteId;
  set nowCreatedNoteId(int val) {
    _nowCreatedNoteId = val;
    notifyListeners();
  }

  bool _isEventsLoad = false;
  bool get isEventsLoad => _isEventsLoad;
  set isEventsLoad(bool val) {
    _isEventsLoad = val;
    notifyListeners();
  }

  List<Note> _notes = [];

  List<Note> get notes => _notes;

  set notes(List val) {
    _notes = val;
    notifyListeners();
  }

  void updateNote(String text, int id) {
    _notes[id].content = text;
    notifyListeners();
  }

  void addNote(Note note) {
    _notes.add(note);
    _notesCount += 1;
    notifyListeners();
  }

  Future<List<int>> unSelectAllNotes() async {
    List<int> idList = [];
    for (var i = 0; i < _notes.length; i++) {
      if (_notes[i].isSelected) {
        idList.add(_notes[i].id);
        _notes.removeAt(i);
        _selectedCount--;
      }
    }
    await DBNoteProvider.db.deleteCheckedNotes(idList);
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

  loadNotes() async {
    if (!_isEventsLoad) {
      _notes = await DBNoteProvider.db.getAllNotesSearch(_searchText);
      _isEventsLoad = true;
      _notesCount = _notes.length;
      notifyListeners();
    }
  }
}
