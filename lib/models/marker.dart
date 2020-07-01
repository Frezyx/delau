import 'dart:convert';

class Marker {
  int id;
  String name;
  String icon;
  int userID;

  Marker({
    this.id,
    this.name,
    this.icon,
    this.userID,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'userID': userID,
    };
  }

  static Marker fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Marker(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      userID: map['userID'],
    );
  }

  String toJson() => json.encode(toMap());

  static Marker fromJson(String source) => fromMap(json.decode(source));
}
