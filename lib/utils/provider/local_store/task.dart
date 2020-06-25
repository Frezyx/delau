import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:delau/models/dbModels.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Task ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "date TEXT,"
          "time TEXT,"
          "priority INTEGER,"
          "marker INTEGER,"
          "icon INTEGER,"
          "passed INTEGER,"
          "deleted INTEGER,"
          "done BIT"
          ")");
    });
  }

  newClient(Task newClient) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Task");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Task (id,title,description,date,time,priority,marker,icon,passed,deleted,done)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?)",
        [id, 
        newClient.title,
        newClient.description,
        newClient.date,
        newClient.time,
        newClient.priority,
        newClient.marker,
        newClient.icon,
        newClient.passed,
        newClient.deleted,
        newClient.done
        ]);
    print(id.toString() + " ID отправлено с icon == "+ newClient.icon.toString());
    return id;
  }

  blockOrUnblock(Task client) async {
    final db = await database;
    Task blocked = Task(
        id: client.id,
        title: client.title,
        description: client.description,
        date: client.date,
        time: client.time,
        priority: client.priority,
        icon: client.icon,
        marker: client.marker,
        passed: client.passed,
        deleted: client.deleted,
        done: !client.done);

    var res = await db.update("Task", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(Task newClient) async {
    final db = await database;
    var res = await db.update("Task", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  Future<int> getContNow() async {
    final db = await database;
    var res = await Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Task WHERE deleted = 0'));
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Task", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : null;
  }

  passDate(int id) async {
    final db = await database;
    var s = 1;
    int count = await db.rawUpdate(
      'UPDATE Task SET passed = ? WHERE id = ?',
      ['$s', '$id']);
    print('updated: $count');
  }

    Future<List<Task>> getClientInList(int id) async {
    final db = await database;
    var res = await db.query("Task", where: "id = ?", whereArgs: [id]);
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Task>> getBlockedClients() async {
    final db = await database;

    print("works");
    var res = await db.query("Task", where: "blocked = ? ", whereArgs: [1]);

    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Task>> getAllTasks() async {
    final db = await database;
    var res = await db.query("Task",where: "deleted = 0", orderBy: "done ASC, priority DESC, date DESC, time DESC ");
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  Future<int> deleteClient(int id) async {
    final db = await database;
    var table = await db.rawQuery("SELECT priority FROM Task WHERE id = ?",[id]);
    int priority = table.first["priority"];

    int count = await db.rawUpdate(
      'UPDATE Task SET deleted = 1 WHERE id = ?',
        ['$id']);
    print('Удаление updated: $count');
    return priority;
  }

  deleteAll() async {
    final db = await database;
    int count = await db.rawUpdate(
      'UPDATE Task SET deleted = ? WHERE id = *',
        ['1']);
    print('Удаление updated: $count');
  }
}