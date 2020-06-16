import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:delau/utils/synchroneHelper.dart';
import 'package:flutter/material.dart';
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

class DBNoteProvider {
  DBNoteProvider._();

  static final DBNoteProvider db = DBNoteProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Notes.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Notes ("
          "id INTEGER PRIMARY KEY,"
          "content TEXT,"
          "date_last_edited INTEGER,"
          "is_archived INTEGER,"
          "color INTEGER"
          ")");
    });
  }

  firstCreateTable() async{
    final db = await database;
    int now = epochFromDate(DateTime.now());
    int id = 0;
    var raw = await db.rawInsert(
        "INSERT Into Notes (id, content, date_last_edited, is_archived, color)"
        " VALUES (?, ?, ?, ?, ?)",
        [id, 'Бысртрая задча #1', now, 0, 0]
        );
    return(id);
  }

  int epochFromDate(DateTime dt) {  
    return dt.millisecondsSinceEpoch ~/ 1000;
  }

  Future<int>addNote(String text) async{
    final db = await database;
    int now = epochFromDate(DateTime.now());
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Notes");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Notes (id, content, date_last_edited, is_archived, color)"
        " VALUES (?, ?, ?, ?, ?)",
        [id, '$text', now, 0, 0]
        );

    return(id);
  }

  Future<int>updateNote(String text, int id) async{
    final db = await database;
    int now = epochFromDate(DateTime.now());
    int count = await db.rawUpdate(
      'UPDATE Notes SET content = ?, date_last_edited = ? WHERE id = ?',
      ['$text','$now', '$id']);
    return(count);
  }

  Future<int>updateColor(int id) async{
    print("На выбор получил айди" + id.toString());
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Notes WHERE id = $id");
    var item = res.first;
    var colorSQL = item['color'];

    int color;
    if(colorSQL == 0){color = 1;}
    else{color = 0;}
    
    int count = await db.rawUpdate(
      'UPDATE Notes SET color = ? WHERE id = ?',
      ['$color','$id']);
    return(color);
  }

  Future<int>updateColorFalse(int id, int color) async{
    final db = await database;
    int count = await db.rawUpdate(
      'UPDATE Notes SET color = ? WHERE id = ?',
      ['$color','$id']);
    return(id);
  }

    Future<int>addNoteInit() async{
    var rng = new Random();
    List<String> randomText= [
      'Компьютерные технологии стали неотъемлемой частью жизни людей. Эти технологии имеют свои корни. Возьмём, например, слово «мышка». Компьютерная мышь совсем не то же самое, что маленький грызун, который живёт в зданиях и полях. Это небольшой прибор, который вы двигаете туда-сюда по плоской поверхности, сидя за компьютером. Мышь перемещает стрелку (или курсор) на экране компьютера. Идея такого устройства пришла в голову специалисту по компьютерам Дугласу Энгельбарту в начале 60-х годов XX века. Первая компьютерная мышь представляла собой резной деревянный кубик с двумя металлическими колёсиками. Прибор назвали мышью, так как с одного конца у него был хвостик. Хвостом был провод, который присоединял устройство к компьютеру.',
      'С другой стороны постоянное информационно-пропагандистское',
      'Не следует, однако забывать, что консультация с широким активом обеспечивает широкому кругу (специалистов) участие в формировании направлений',
      'рост и сфера нашей',
      'Счастлив ?'
    ];
    final db = await database;
    int now = epochFromDate(DateTime.now());
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Notes");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Notes (id, content, date_last_edited, is_archived, color)"
        " VALUES (?, ?, ?, ?, ?)",
        [id, randomText[rng.nextInt(4)], now, 0, 0]
        );
    return(raw);
  }

  Future<int> deleteCheckedNotes() async{
    final db = await database;
    var res = await db.query("Notes", where: "color = 1");
    print(res.toString()+" Количество заметок с измененным цветом");
    List<Note> list = res.isNotEmpty ? res.map((c) => Note.fromMap(c)).toList() : [];
    for (int i = 0; i <list.length; i++){
      await db.rawUpdate('UPDATE Notes SET is_archived = ?, color = ? WHERE id = ?', [1,0,'${list[i].id}'])
      .then((respa){
        print("$respa Удалил");
      });
    }
    return 1;
  }

  Future<int> recoverNotes() async{
    final db = await database;
    var res = await db.query("Notes", where: "color = 1");
    print(res.toString()+" Количество заметок с измененным цветом");
    List<Note> list = res.isNotEmpty ? res.map((c) => Note.fromMap(c)).toList() : [];
    for (int i = 0; i <list.length; i++){
      await db.rawUpdate('UPDATE Notes SET color = ? WHERE id = ?', [0,'${list[i].id}'])
      .then((respa){
        print("$respa Удалил");
      });
    }
    return 1;
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    var res = await db.query("Notes", where: "is_archived = ?", whereArgs: [0], orderBy: "date_last_edited DESC");
    List<Note> list =
        res.isNotEmpty ? res.map((c) => Note.fromMap(c)).toList() : [];
        for (int i = 0; i <list.length; i++){
        }
    return list;
  }

    Future<List<Note>> getAllNotesSearch(String text) async {
    final db = await database;
    var res = await db.query("Notes", where: "is_archived = ? AND content LIKE ?", whereArgs: [0, "%$text%"], orderBy: "date_last_edited DESC");
    List<Note> list =
        res.isNotEmpty ? res.map((c) => Note.fromMap(c)).toList() : [];
        for (int i = 0; i <list.length; i++){
        }
    print(list.length.toString() + "Кол-во ссаных заметок");
    return list;
  }

  Future<String> getNoteById(int i) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Notes WHERE id = $i");
      var item = res.first;
      var content = item['content'];
    return content;
  }
  
  Future<int> getArchivedCount() async{
    final db = await database;
    var archivedNotesCount = Sqflite.firstIntValue( await db.rawQuery("SELECT COUNT(*) FROM Notes WHERE color = 1"));
    return archivedNotesCount;
  }
}