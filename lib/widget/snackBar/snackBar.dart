import 'package:flutter/material.dart';

class SnackBarCustom {
  static final snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text('Данные сохранены'),
  );

  static final badRegSnackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text('Ошибка регистрации'),
  );

  static final badAuthSnackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text('Ошибка входа'),
  );
}
