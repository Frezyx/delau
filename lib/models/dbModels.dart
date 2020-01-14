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
  bool done;

  Client({
		this.id,
		this.title,
		this.description,
		this.priority,
    this.marker,
		this.date,
    this.time,
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
        "done": done,
      };
}