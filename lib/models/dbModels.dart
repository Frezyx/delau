import 'dart:convert';

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String title;
  String description;
  String date;
  String time;
  int priority;
  int marker;
  int passed;
  int deleted;
  bool done;

  Client({
		this.id,
		this.title,
		this.description,
		this.priority,
    this.marker,
		this.date,
    this.time,
    this.passed,
    this.deleted,
    this.done,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        priority: json["priority"],
        marker: json["marker"],
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