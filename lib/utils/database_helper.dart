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
        "INSERT Into Client (id,title,description,date,time,priority,marker,done)"
        " VALUES (?,?,?,?,?,?,?,?)",
        [id, 
        newClient.title,
        newClient.description,
        newClient.date,
        newClient.time,
        newClient.priority,
        newClient.marker,
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
    return db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}

class DBCountProvider {
  DBCountProvider._();

  static final DBCountProvider dbc = DBCountProvider._();

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
      await db.execute("CREATE TABLE ClientCount ("
          "id INTEGER PRIMARY KEY,"
          "countAdd INTEGER,"
          "countDone INTEGER"
          ")");
    });
  }

  updateCount() async {
    final db = await database;
    //get the biggest id in the table
    // var isset = await db.rawQuery('SELECT EXISTS(SELECT * FROM ClientCount WHERE id = 0)');
    // if(isset == 1){
      var table = await db.rawQuery("SELECT * FROM ClientCount WHERE id = 1");
      int countAddNow = table.first["countAdd"];
      int nextAdd = countAddNow;
      int countDoneNow = table.first["countDone"]; 
        ClientCounter now_client = new ClientCounter(
          id: 1,
          countAdd: nextAdd,
          countDone: countDoneNow,
        );
        print("aaaaaaaaaa    ///     "+countAddNow.toString());
        updateClientCountRaw(now_client);
  }

  firstCreateTable() async{
    final db = await database;
    
    var raw = await db.rawInsert(
        "INSERT Into ClientCount (id,countAdd,countDone)"
        " VALUES (?,?,?)",
        [1, 0, 0]
        );

    return raw;
  }
  updateClientCount(ClientCounter newClient) async {
    final db = await database;
var res = await db.update("ClientCount", newClient.toMap(),
    where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

    updateClientCountRaw(ClientCounter newClient) async {
    final db = await database;
    int nextAdd = newClient.countAdd + 1;
    int count = await db.rawUpdate(
      'UPDATE ClientCount SET countAdd = ? WHERE id = ?',
      ['$nextAdd', '1']);
  print('updated: $count');
  }

  Future<ClientCounter> getClientCounter(int id) async {
    final db = await database;
    var res = await db.query("ClientCount", where: "id = ?", whereArgs: [id]);
    return ClientCounter.fromMap(res.first);
  }

    Future<List<ClientCounter>> getClientCounterInList() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM ClientCount WHERE id = 1");
    List<ClientCounter> list =
        res.isNotEmpty ? res.map((c) => ClientCounter.fromMap(c)).toList() : [];
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


      // Column(
      //   children: [
      //     DecoratedBox(  // add this
      //       child: new Column(
      //   children: <Widget>[
      //    CarouselSlider(
      //     items: [
      //       1,
      //       2,
      //       3,
      //       4,
      //       5,
      //       6].map((i) {
      //       return new Builder(
      //         builder: (BuildContext context) {
      //           return new Container(
      //             width: MediaQuery.of(context).size.width,
      //             margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 70.0, bottom: 50.0),
      //             decoration: new BoxDecoration(
      //               color: Colors.white,
      //               boxShadow:<BoxShadow>[
      //                 BoxShadow(
      //                   color: Color.fromRGBO(71, 9, 150, 0.37),
      //                   offset: Offset(0.0, 4.0),
      //                   blurRadius: 15.0,
      //                 ),
      //               ],
      //                   border: Border.all(
      //                     color: Colors.transparent,
      //                     width: 0,
      //                   ),
      //                   borderRadius: BorderRadius.circular(12),
      //             ),
      //             child: getCardInfo(i, i_add, slider_titles)
      //           );
      //         },
      //       );
      //     }).toList(),
      //     height: 280.0,
      //     autoPlay: true,
      //     autoPlayCurve: Curves.elasticIn,
      //     autoPlayDuration: const Duration(milliseconds: 2800),
      //       ),
      //      ]
      //     ),