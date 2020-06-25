import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:delau/models/dbModels.dart';
import 'package:sqflite/sqflite.dart';

class DBMarkerProvider {
  DBMarkerProvider._();

  static final DBMarkerProvider db = DBMarkerProvider._();

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

  firstCreateTable() async{
    final db = await database;
    int id = 0;
    var raw = await db.rawInsert(
        "INSERT Into Markers (id, name, icon)"
        " VALUES (?, ?, ?)",
        [id,'Добавить', 'plus']
        );

    return(id);
  }

  Future<int>addMarker(Marker mark) async{
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Markers");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Markers (id, name, icon)"
        " VALUES (?,?,?)",
        [id, 
        mark.name,
        mark.icon,
        ]);
      print(raw);
    return raw;
  }

  Future<List<Marker>> getAllMarks() async {
    final db = await database;
    var res = await db.query("Markers");
    List<Marker> list =
        res.isNotEmpty ? res.map((c) => Marker.fromMap(c)).toList() : [];
    return list;
  }

  Future<String> getMarkById(int i) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Markers WHERE id = $i");
      var item = res.first;
      var icon = item['icon'];
      print(icon);
    return icon;
  }

}
