import 'dart:async';
import 'dart:io';
import 'package:delau/models/marker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MarkerDB {
  MarkerDB._();

  static final MarkerDB db = MarkerDB._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Markers.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Markers ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "icon TEXT"
          ")");
    });
  }

  Future<bool> add(Marker marker) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Markers");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Markers (id, name, icon)"
        " VALUES (?, ?, ?)",
        [
          id,
          marker.name,
          marker.icon,
        ]);
    return id == raw;
  }

  Future<int> updateOnly(String paramName, param, id) async {
    final db = await database;
    int count = await db.rawUpdate(
        "UPDATE Markers SET $paramName = ? WHERE id = ?", ['$param', id]);
    return count;
  }

  Future<List<Marker>> getAll() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Markers");
    List<Marker> list =
        res.isNotEmpty ? res.map((c) => Marker.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> deleteById(int id) async {
    final db = await database;
    var res = await db.rawQuery("DELETE FROM Markers WHERE id = '$id'");
    return res.length;
  }

  deleteAll() async {
    final db = await database;
    db.rawQuery("DELETE FROM Markers");
  }
}
