import 'dart:convert';
import 'package:delau/utils/convert/epochFromDate.dart';
import 'package:intl/intl.dart';

class Task {
  int id;
  String name;
  String description;
  bool isOpen;
  bool isChecked;
  String icon;
  int markerID;
  DateTime date;
  DateTime time;
  int userID;

  Task({
    this.id,
    this.name,
    this.description,
    this.isOpen,
    this.isChecked,
    this.icon,
    this.date,
    this.time,
    this.markerID,
    this.userID,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isOpen': isOpen,
      'isChecked': isChecked,
      'icon': icon,
      'markerID': markerID,
      'date': epochFromDate(date),
      'time': epochFromDate(time),
      'userID': userID,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Task(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      isChecked: map['is_done'],
      icon: map['marker_name'],
      markerID: map['marker_id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      userID: map['user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  static Task fromJson(String source) => fromMap(json.decode(source));
}
