import 'dart:async';
import 'dart:io';
import 'package:delau/utils/synchroneHelper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:delau/models/dbModels.dart';
import 'package:sqflite/sqflite.dart';

class DBUserProvider {
  DBUserProvider._();

  static final DBUserProvider dbc = DBUserProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Count.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ClientUser ("
          "id INTEGER PRIMARY KEY,"
          "userIdServer INTEGER,"
          "name TEXT,"
          "surname TEXT,"
          "countAdd INTEGER,"
          "countDone INTEGER,"
          "rating INTEGER,"
          "reg INTEGER"
          ")");
    });
  }

    registrationClient(_name, _surname, userId) async {
    final db = await database;
      var table = await db.rawQuery("SELECT * FROM ClientUser WHERE id = 1");
      int countAddNow = table.first["countAdd"];
      int countDoneNow = table.first["countDone"];
      int rating = table.first["rating"]; 
      int registration = 1;
        ClientUser now_client = new ClientUser(
          id: 1,
          userIdServer: userId,
          name: _name,
          surname: _surname,
          countAdd: countAddNow,
          countDone: countDoneNow,
          rating: rating,
          reg: registration,
        );
        print("Регистрация прошла успешно код:"+now_client.reg.toString()+"  Id на сервере: "+now_client.userIdServer.toString());
        regUserRaw(now_client);
  }

    exitClient() async {
      final db = await database;
      int reg = 0;
      int count = await db.rawUpdate(
        'UPDATE ClientUser SET reg = ? WHERE id = ?',
        ['$reg', '1']);
      print('updated: $count');
    }

    loginClient(row) async {
      final db = await database;
      var name = row[1];
      var surname = row[2];
      var id = row[3];
      var rating = row[4];
      var countDone = row[5];
      var countAdd = row[6];
      int reg = 1;
      int count = await db.rawUpdate(
        'UPDATE ClientUser SET reg = ?, name = ?, surname = ?, rating = ?, countDone = ?, countAdd = ? WHERE id = ?',
        ['$reg', '$name', '$surname', '$rating', '$countDone', '$countAdd', '1']);
      print('updated: $count');
      //TODO: Change this func
      runSyncLogin(id);
    }

  updateCount() async {
    final db = await database;
      var table = await db.rawQuery("SELECT * FROM ClientUser WHERE id = 1");
      int userIdServer = table.first["userIdServer"];
      String name = table.first["name"];
      String surname = table.first["surname"];
      int countAddNow = table.first["countAdd"];
      int nextAdd = countAddNow + 1;
      int countDoneNow = table.first["countDone"];
      int rating = table.first["rating"]; 
      int reg = table.first["reg"]; 
        ClientUser now_client = new ClientUser(
          id: 1,
          userIdServer:userIdServer,
          name: name,
          surname: surname,
          countAdd: nextAdd,
          countDone: countDoneNow,
          rating: rating,
          reg: reg,
        );
        updateClientUserRaw(now_client);
  }

  updateCountDone(int pr) async {
    final db = await database;
      var table = await db.rawQuery("SELECT * FROM ClientUser WHERE id = 1");
      int userIdServer = table.first["userIdServer"];
      String name = table.first["name"];
      String surname = table.first["surname"];
      int countAddNow = table.first["countAdd"];
      int countDoneNow = table.first["countDone"]; 
      int nextDone = countDoneNow + 1;
      int rating = table.first["rating"]; 
      int nextRating = rating + pr ~/ 2;
      int reg = table.first["reg"]; 
        ClientUser now_client = new ClientUser(
          id: 1,
          userIdServer:userIdServer,
          name: name,
          surname: surname,
          countAdd: countAddNow,
          countDone: nextDone,
          rating: nextRating,
          reg: reg,
        );
        updateClientUserDoneRaw(now_client);
  }

  firstCreateTable() async{
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into ClientUser (id, userIdServer, name, surname, countAdd, countDone, rating, reg)"
        " VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [1, 1, "", "", 0, 0, 0, 0]
        );

    return raw;
  }
  updateClientUser(ClientUser newClient) async {
    final db = await database;
var res = await db.update("ClientUser", newClient.toMap(),
    where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  updateClientUserRaw(ClientUser newClient) async {
    final db = await database;
    int nextAdd = newClient.countAdd;
    int count = await db.rawUpdate(
      'UPDATE ClientUser SET countAdd = ? WHERE id = ?',
      ['$nextAdd', '1']);
  print('updated: $count');
  }

    regUserRaw(ClientUser newClient) async {
      print("regUserRaw принял ID:"+newClient.userIdServer.toString());
      final db = await database;
      String name = newClient.name;
      String surname = newClient.surname;
      var reg = newClient.reg.toString();
      var userIdServer = newClient.userIdServer.toString();
      int count = await db.rawUpdate(
        'UPDATE ClientUser SET name = ?, surname = ?, reg = ?, userIdServer = ? WHERE id = ?',
        ['$name', '$surname', '$reg', '$userIdServer', '1']);
  print('updated: $count ---> результат c UserId ---> $userIdServer');
  }

    updateClient( name , surname, email, login, userId)async {
      final db = await database;
      var idUser = userId;
      int count = await db.rawUpdate(
        'UPDATE ClientUser SET name = ?, surname = ? WHERE userIdServer = ?',
        ['$name', '$surname', '$idUser']);

      print('updated: $count ---> результат c UserId ---> $idUser');
  }

  updateClientUserDoneRaw(ClientUser newClient) async {
    final db = await database;
    int nextDone = newClient.countDone;
    int nextRating = newClient.rating;
    int count = await db.rawUpdate(
      'UPDATE ClientUser SET countDone = ?, rating = ? WHERE id = ?',
      ['$nextDone', '$nextRating', '1']);
  print('updated: $count');
  }

  Future<ClientUser> getClientUser(int id) async {
    final db = await database;
    var res = await db.query("ClientUser", where: "id = ?", whereArgs: [id]);
    return ClientUser.fromMap(res.first);
  }
  Future<int> getUserId() async {
    final db = await database;
      var res = await db.rawQuery("SELECT * FROM ClientUser WHERE id = 1");
      var item = res.first;
      var resourceId = item['userIdServer'];
      print("id:"+item['id'].toString()+"UserId:"+resourceId.toString()+"name:"+item['name']);
    return resourceId;
  }

    Future<List<ClientUser>> getClientUserInList() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM ClientUser WHERE id = 1");
    List<ClientUser> list =
        res.isNotEmpty ? res.map((c) => ClientUser.fromMap(c)).toList() : [];
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
    var res = await db.query("Task", orderBy: "done ASC, priority DESC, date DESC, time DESC ");
    List<Task> list =
        res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Task");
  }
}