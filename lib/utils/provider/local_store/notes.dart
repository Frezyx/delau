import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:delau/models/dbModels.dart';
import 'package:sqflite/sqflite.dart';

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

  firstCreateTable() async {
    final db = await database;
    int now = epochFromDate(DateTime.now());
    int id = 0;
    var raw = await db.rawInsert(
        "INSERT Into Notes (id, content, date_last_edited, is_archived, color)"
        " VALUES (?, ?, ?, ?, ?)",
        [id, 'Бысртрая задча #1', now, 0, 0]);
    return (id);
  }

  int epochFromDate(DateTime dt) {
    return dt.millisecondsSinceEpoch ~/ 1000;
  }

  Future<int> addNote(String text) async {
    final db = await database;
    int now = epochFromDate(DateTime.now());
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Notes");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Notes (id, content, date_last_edited, is_archived, color)"
        " VALUES (?, ?, ?, ?, ?)",
        [id, '$text', now, 0, 0]);

    return (id);
  }

  Future<int> updateNote(String text, int id) async {
    final db = await database;
    int now = epochFromDate(DateTime.now());
    int count = await db.rawUpdate(
        'UPDATE Notes SET content = ?, date_last_edited = ? WHERE id = ?',
        ['$text', '$now', '$id']);
    return (count);
  }

  Future<int> updateColor(int id) async {
    print("На выбор получил айди" + id.toString());
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Notes WHERE id = $id");
    var item = res.first;
    var colorSQL = item['color'];

    int color;
    if (colorSQL == 0) {
      color = 1;
    } else {
      color = 0;
    }

    int count = await db.rawUpdate(
        'UPDATE Notes SET color = ? WHERE id = ?', ['$color', '$id']);
    return (color);
  }

  Future<int> updateColorFalse(int id, int color) async {
    final db = await database;
    int count = await db.rawUpdate(
        'UPDATE Notes SET color = ? WHERE id = ?', ['$color', '$id']);
    return (id);
  }

  Future<int> addNoteInit() async {
    var rng = new Random();
    List<String> randomText = [
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
        [id, randomText[rng.nextInt(4)], now, 0, 0]);
    return (raw);
  }

  Future<int> deleteCheckedNotes(List<int> list) async {
    final db = await database;
    for (int i = 0; i < list.length; i++) {
      await db.rawUpdate('UPDATE Notes SET is_archived = ? WHERE id = ?',
          [1, '${list[i]}']).then((respa) {});
    }
    return 1;
  }

  Future<int> recoverNotes() async {
    final db = await database;
    var res = await db.query("Notes", where: "color = 1");
    print(res.toString() + " Количество заметок с измененным цветом");
    List<Note> list =
        res.isNotEmpty ? res.map((c) => Note.fromMap(c)).toList() : [];
    for (int i = 0; i < list.length; i++) {
      await db.rawUpdate('UPDATE Notes SET color = ? WHERE id = ?',
          [0, '${list[i].id}']).then((respa) {
        print("$respa Удалил");
      });
    }
    return 1;
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    var res = await db.query("Notes",
        where: "is_archived = ?",
        whereArgs: [0],
        orderBy: "date_last_edited DESC");
    List<Note> list =
        res.isNotEmpty ? res.map((c) => Note.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> getAllNotesCount() async {
    final db = await database;
    var res = await db.query("Notes",
        where: "is_archived = ?",
        whereArgs: [0],
        orderBy: "date_last_edited DESC");
    List<Note> list =
        res.isNotEmpty ? res.map((c) => Note.fromMap(c)).toList() : [];
    return list.length;
  }

  Future<List<Note>> getAllNotesSearch(String text) async {
    final db = await database;
    var res = await db.query("Notes",
        where: "is_archived = ? AND content LIKE ?",
        whereArgs: [0, "%$text%"],
        orderBy: "date_last_edited DESC");
    List<Note> list =
        res.isNotEmpty ? res.map((c) => Note.fromMap(c)).toList() : [];
    for (int i = 0; i < list.length; i++) {}
    return list;
  }

  Future<String> getNoteById(int i) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Notes WHERE id = $i");
    var item = res.first;
    var content = item['content'];
    return content;
  }

  Future<int> getArchivedCount() async {
    final db = await database;
    var archivedNotesCount = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM Notes WHERE color = 1"));
    return archivedNotesCount;
  }
}
