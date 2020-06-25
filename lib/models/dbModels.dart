import 'dart:convert';

Task clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromMap(jsonData);
}

String clientToJson(Task data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Task {
  int id;
  String title;
  String description;
  String date;
  String time;
  int priority;
  int marker;
  String icon;
  int passed;
  int deleted;
  bool done;

  Task({
		this.id,
		this.title,
		this.description,
		this.priority,
    this.marker,
    this.icon,
		this.date,
    this.time,
    this.passed,
    this.deleted,
    this.done,
  });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        priority: json["priority"],
        marker: json["marker"],
        icon: json["icon"],
        date: json["date"],
        time: json["time"],
        passed: json["passed"],
        deleted: json["deleted"],
        done: json["done"] == 1,
      );
  
      
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "priority": priority,
        "marker": marker,
        "icon": icon,
        "date": date,
        "time": time,
        "passed": passed,
        "deleted": deleted,
        "done": done,
      };
}

ClientUser ClientUserFromJson(String str) {
  final jsonData = json.decode(str);
  return ClientUser.fromMap(jsonData);
}

String ClientUserToJson(ClientUser data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ClientUser {
  int id;
  int userIdServer;
  String name;
  String surname;
  int countDone;
  int countAdd;
  int rating;
  int reg;

  ClientUser({
		this.id,
    this.userIdServer,
    this.name,
    this.surname,
		this.countAdd,
		this.countDone,
    this.rating,
    this.reg,
  });

  factory ClientUser.fromMap(Map<String, dynamic> json) => new ClientUser(
        id: json["id"],
        userIdServer: json["userIdServer"],
        name: json["name"],
        surname: json["surname"],
        countAdd: json["countAdd"],
        countDone: json["countDone"],
        rating: json["rating"],
        reg: json["reg"],
      );
      
  Map<String, dynamic> toMap() => {
        "id": id,
        "userIdServer": userIdServer,
        "name": name,
        "surname" : surname,
        "countAdd": countDone,
        "countDone": countDone,
        "rating": rating,
        "reg": reg,
      };
}

class Marker {
  int id;
  String name;
  String icon;

  Marker({
		this.id,
    this.name,
    this.icon
  });

  factory Marker.fromMap(Map<String, dynamic> json) => new Marker(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );
      
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}


class Note {
  int id;
  String content;
  DateTime date_last_edited;
  int is_archived;
  int color;
  bool isSelected;

  Note({
    this.id, 
    this.content, 
    this.is_archived, 
    this.date_last_edited,
    this.color,
    this.isSelected,
  });

  factory Note.fromMap(Map<String, dynamic> json) => new Note(
        id: json["id"],
        content: json["content"],
        is_archived: json["is_archived"],
        date_last_edited: DateTime.fromMillisecondsSinceEpoch(json["date_last_edited"]),
        color: json["color"],
        isSelected: json["isSelected"],
      );
      
  Map<String, dynamic> toMap() => {
        "id": id,
        'content': content,
        'is_archived': is_archived,
        'date_last_edited': epochFromDate( date_last_edited ),
        'color': color,
        'isSelected': isSelected,
      };

      epochFromDate(DateTime dt) {  
        return dt.millisecondsSinceEpoch ~/ 1000;
      }
}
