import 'dart:async';
import 'dart:io';
import 'package:delau/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
          "token TEXT,"
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
          "INSERT Into Users (id, token, isauth)"
          "VALUES (?,?,?)",
          [
            user.id,
            user.authToken,
            1,
          ]);

      response = raw == user.id;
    } else {
      response = 1 == await userLogin(user);
    }
    return response;
  }

  Future<int> userLogin(User user) async {
    final db = await database;
    int count = await db.rawUpdate(
        "UPDATE Users SET isauth = 1 , token = ? WHERE id = '${user.id}'",
        [user.authToken]);
    return count;
  }

  Future<bool> isSetAuthUser() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Users WHERE isauth = 1");
    return res.length > 0;
  }

  Future<bool> userLogOut() async {
    final db = await database;
    int count = await db.rawUpdate(
        "UPDATE Users SET isauth = 0 , token = ? WHERE isauth = 1", [""]);
    return count == 1;
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
