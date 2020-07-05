import 'package:delau/blocs/notesListBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:delau/widget/buttons/allertButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNoteAlert extends StatefulWidget {
  @override
  _AddNoteAlertState createState() => _AddNoteAlertState();
}

class _AddNoteAlertState extends State<AddNoteAlert> {
  String noteText;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final noteListBloc = Provider.of<NotesListBloc>(context);

    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 14.0, top: 4.0, left: 8.0, right: 8.0),
                child: Text(
                  "Добавление заметки",
                  style: DesignTheme.alert.bigText,
                ),
              ),
              buildTitleTextField(noteListBloc),
              SizedBox(height: 5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getBottomButton("Отменить", Icons.add, Colors.red, context,
                        close, true, _formKey),
                    getBottomButton(
                        "Сохранить",
                        Icons.add,
                        DesignTheme.mainColor,
                        context,
                        validate,
                        false,
                        _formKey),
                  ]),
            ]),
          ),
        ),
      ],
    ));
  }

  validate(_formKey) {
    _formKey.currentState.validate();
  }

  close(context) {
    Navigator.pop(context);
  }

  Widget buildTitleTextField(noteListBloc) {
    return TextFormField(
      key: Key('title_task'),
      onTap: () {},
      minLines: 10,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      cursorColor: DesignTheme.mainColor,
      decoration: InputDecoration(
        hintText: "Введите вашу заметку",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTheme.normalBorderRadius),
          borderSide: BorderSide(
            style: BorderStyle.solid,
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty)
          return 'Введите вашу заметку';
        else {
          DBNoteProvider.db.addNote(value.toString()).then((res) {
            noteListBloc.addNote(Note(id: res, isSelected: false));
            Navigator.pop(context);
          });
        }
      },
    );
  }
}
