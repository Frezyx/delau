import 'package:delau/blocs/notesListBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/widget/alerts/addNote.dart';
import 'package:delau/widget/pages/notes/notesListBody.dart';
import 'package:flutter/material.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:speech_recognition/speech_recognition.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  PermissionStatus _permissionStatus;
  ScrollController scrollController;
  String searchText;
  bool dialVisible = true;
  bool isSaerching = false;

  SpeechRecognition _speechRecognition;

  bool _isAvailable = false;
  bool _isListening = false;
  bool sender = true;
  String id;
  String resultText = "";

  var noteListBloc;

  int notesCount = 0;

  postNote(text) {
    if (!sender) {
      DBNoteProvider.db.updateNote(text, int.parse(id)).then((res) {});
    }
    if (sender) {
      DBNoteProvider.db.addNote(text).then((res) {
        setSender();
        id = res.toString();
        noteListBloc.addNote(Note(id: res, isSelected: false));
      });
    }
  }

  void setSender() {
    setState(() {
      sender = false;
    });
  }

  startRecognition() {
    _speechRecognition.listen(locale: "ru_RU").then((result) {
      print('$result');
    });
    _isListening = true;
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) =>
          setState(() => speech != "" ? postNote(speech) : resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  void startSearch(String text) {
    setState(() {
      isSaerching = true;
      searchText = text;
    });
  }

  @override
  void initState() {
    super.initState();

    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone)
        .then(_updateStatus);

    initSpeechRecognizer();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });

    DBNoteProvider.db.recoverNotes();
  }

  void _updateStatus(PermissionStatus status) {
    if (_permissionStatus != status) {
      setState(() {
        _permissionStatus = status;
      });
    }
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
      print("$value");
    });
  }

  void askPermision() {
    PermissionHandler().requestPermissions([PermissionGroup.microphone]).then(
        _onStatusRequested);
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.microphone];
    _updateStatus(status);
  }

  @override
  Widget build(BuildContext context) {
    noteListBloc = Provider.of<NotesListBloc>(context);

    DBNoteProvider.db.getAllNotesCount().then((count) {
      setState(() {
        notesCount = count;
      });
    });

    // DBNoteProvider.db.getAllNotesCount();
    // final noteListBloc = Provider.of<NotesListBloc>(context);

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints.expand(height: 160),
                  decoration: BoxDecoration(
                      color: DesignTheme.mainColor,
                      // gradient: DesignTheme.gradientButton,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 45,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Заметки", style: DesignTheme.bigWhite),
                                  Text("$notesCount",
                                      style: DesignTheme.bigWhite),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: DesignTheme.searchFormShadow,
                              ),
                              child: TextFormField(
                                onTap: () {
                                  //Change shadow
                                },
                                onChanged: (text) {
                                  startSearch(text);
                                },
                                style: DesignTheme.listItemLabel,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  icon: Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      color: DesignTheme.mainColor,
                                    ),
                                  ),
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15.0),
                                  labelText: 'Поиск по заметкам...',
                                  border: InputBorder.none,
                                  labelStyle: DesignTheme.notesSearchText,
                                ),
                                onEditingComplete: () {},
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                NotesListBody(
                    isSaerching: isSaerching,
                    searchText: searchText,
                    scrollController: scrollController)
              ],
            ),
            floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _isListening
                      ? buildCloseAddingButton()
                      : buildVoiceAddingButton(),
                  buildTextAddingButton(context),
                  noteListBloc.isAnNoteSelected
                      ? buildNoteDeleteButton(noteListBloc)
                      : Padding(padding: EdgeInsets.only(left: 0)),
                ])));
  }

  Widget buildNoteDeleteButton(noteListBloc) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: ClipOval(
          child: Material(
        color: Colors.red,
        child: InkWell(
          splashColor: Colors.red[900],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          onTap: () {
            noteListBloc.unSelectAllNotes();
          },
        ),
      )),
    );
  }

  Widget buildTextAddingButton(context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: ClipOval(
          child: Material(
        color: DesignTheme.mainColor,
        child: InkWell(
          splashColor: DesignTheme.secondColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add, color: Colors.white, size: 30),
          ),
          onTap: () {
            getNoteCreateAlert(context);
          },
        ),
      )),
    );
  }

  Widget buildVoiceAddingButton() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
      child: ClipOval(
          child: Material(
        color: DesignTheme.mainColor,
        child: InkWell(
          splashColor: DesignTheme.secondColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.keyboard_voice, color: Colors.white, size: 30),
          ),
          onTap: () {
            askPermision();
            if (_isAvailable && !_isListening) {
              startRecognition();
            } else {
              _speechRecognition.cancel().then(
                    (result) => setState(() {
                      _isListening = result;
                      startRecognition();
                    }),
                  );
            }
          },
        ),
      )),
    );
  }

  Widget buildCloseAddingButton() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
      child: ClipOval(
          child: Material(
        color: Colors.red,
        child: InkWell(
          splashColor: Colors.red[900],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close, color: Colors.white, size: 30),
          ),
          onTap: () {
            _speechRecognition.stop();
          },
        ),
      )),
    );
  }

  getNoteCreateAlert(BuildContext context) {
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
}
