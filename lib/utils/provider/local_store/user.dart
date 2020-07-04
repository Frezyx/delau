import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:delau/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:delau/models/dbModels.dart';
import 'package:sqflite/sqflite.dart';

class UserDB {
  UserDB._();

  static final UserDB udb = UserDB._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Users.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Users ("
          "id INTEGER PRIMARY KEY,"
          "authToken TEXT,"
          "isauth INTEGER"
          ")");
    });
  }

  Future<bool> authUser(User user) async {
    final db = await database;
    bool response;

    var res = await db.rawQuery("SELECT * FROM Users WHERE id = '${user.id}'");

    if (res.length == 0) {
      var raw = await db.rawInsert(
          "INSERT Into Users (id, authToken, isauth)"
          "VALUES (?,?,?)",
          [
            user.id,
            "dd",
            1,
          ]);

      response = raw == user.id;
      print(response.toString() + "Результат локально внутри");
    } else {
      response = 1 == await userLogin(user);
    }
    return response;
  }

  Future<int> userLogin(User user) async {
    final db = await database;
    int count = await db.rawUpdate(
        "UPDATE Users SET isauth = 1 , authToken = ? WHERE id = '${user.id}'",
        [user.authToken]);
    print(count.toString() + "Это у нас апдейт");
    return count;
  }

  Future<bool> isSetAuthUser() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Users WHERE isauth = 1");
    return res.length > 0;
  }

  Future<int> userLogOut(User user) async {
    final db = await database;
    int count = await db.rawUpdate(
        "UPDATE Users SET isauth = 0 , authToken = ? WHERE id = '${user.id}'",
        [""]);

    return count;
  }

  Future<int> updateOnly(String paramName, param) async {
    final db = await database;
    int count = await db.rawUpdate(
        "UPDATE Users SET $paramName = ? WHERE isauth = ?", ['$param', 1]);
    return count;
  }

  Future<User> getUser() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Users WHERE isauth = 1");
    var item = res.first;
    User user = User.fromMap(item);
    return user;
  }
}
