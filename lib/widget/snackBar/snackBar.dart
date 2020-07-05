import 'package:flutter/material.dart';

class SnackBarCustom {
  static final goodEditBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text('Изменения сохранены'),
  );

  static final badRegSnackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text('Ошибка регистрации'),
  );

  static const badEditBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text('Изменения не сохранены'),
  );

  static final badAuthSnackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text('Ошибка входа'),
  );
}
