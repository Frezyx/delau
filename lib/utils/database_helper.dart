import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
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
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Client ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "date TEXT,"
          "time TEXT,"
          "priority INTEGER,"
          "marker INTEGER,"
          "passed INTEGER,"
          "done BIT"
          ")");
    });
  }

  newClient(Client newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Client (id,title,description,date,time,priority,marker,passed,done)"
        " VALUES (?,?,?,?,?,?,?,?,?)",
        [id, 
        newClient.title,
        newClient.description,
        newClient.date,
        newClient.time,
        newClient.priority,
        newClient.marker,
        newClient.passed,
        newClient.done
        ]);
    return raw;
  }

  blockOrUnblock(Client client) async {
    final db = await database;
    Client blocked = Client(
        id: client.id,
        title: client.title,
        description: client.description,
        date: client.date,
        time: client.time,
        priority: client.priority,
        marker: client.marker,
        passed: client.passed,
        done: !client.done);

    var res = await db.update("Client", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  Future<int> getContNow() async {
    final db = await database;
    var res = await Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Client'));
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : null;
  }

  passDate(int id) async {
    final db = await database;
    var s = 1;
    int count = await db.rawUpdate(
      'UPDATE Client SET passed = ? WHERE id = ?',
      ['$s', '$id']);
    print('updated: $count');
  }

    Future<List<Client>> getClientInList(int id) async {
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Client>> getBlockedClients() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    var res = await db.query("Client", orderBy: "done ASC, priority DESC, date DESC, time DESC ");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    var table = await db.rawQuery("SELECT priority FROM Client WHERE id = ?",[id]);
    int priority = table.first["priority"];
    db.delete("Client", where: "id = ?", whereArgs: [id]);
    return priority;
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}

class DBUserProvider {
  DBUserProvider._();

  static final DBUserProvider dbc = DBUserProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
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
        print("Регистрация прошла успешно "+now_client.reg.toString()+"Id на сервере: "+now_client.userIdServer.toString());
        regUserRaw(now_client);
  }

  updateCount() async {
    final db = await database;
    //get the biggest id in the table
    // var isset = await db.rawQuery('SELECT EXISTS(SELECT * FROM ClientUser WHERE id = 0)');
    // if(isset == 1){
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
        print("aaaaaaaaaa    ///     "+countAddNow.toString());
        updateClientUserRaw(now_client);
  }

  updateCountDone(int pr) async {
    final db = await database;
    //get the biggest id in the table
    // var isset = await db.rawQuery('SELECT EXISTS(SELECT * FROM ClientUser WHERE id = 0)');
    // if(isset == 1){
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
        print("Сейчас у нас столько задач Выполненно:      ///     " + nextDone.toString());
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
        'UPDATE ClientUser SET name = ?, surname = ?, reg = ? WHERE id = ?',
        ['$name', '$surname', '$reg', '1']);
  print('updated: $count ---> результат');
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
  //// ????????????
  Future<int> getUserId() async {
    // final db = await database;
    // var res = await db.rawQuery("SELECT userIdServer FROM ClientUser WHERE id = 1");
    // var row = res[0];
    // print("Id юзера на сервере ->"+res[0]['userIdServer'].toString());
    // return row['userIdServer'];
    final db = await database;
    var res = await db.rawQuery("SELECT userIdServer FROM ClientUser WHERE id = 1");
    var item = res.first;
    var resourceId = item['userIdServer'];
    print(resourceId);
    return resourceId;
  }

  // getAllClients() async {
  //   final db = await database;
  //   var res = await db.query("ClientUser");
  //   List<ClientUser> list =
  //       res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
  //   return list[0].userIdServer;

    Future<List<ClientUser>> getClientUserInList() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM ClientUser WHERE id = 1");
    List<ClientUser> list =
        res.isNotEmpty ? res.map((c) => ClientUser.fromMap(c)).toList() : [];
        // if(res.isNotEmpty ){
        //   print("ХУУУЙ");
        // };
    return list;
  }

  Future<List<Client>> getBlockedClients() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    var res = await db.query("Client", orderBy: "done ASC, priority DESC, date DESC, time DESC ");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}
