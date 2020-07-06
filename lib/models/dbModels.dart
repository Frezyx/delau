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
        date_last_edited:
            DateTime.fromMillisecondsSinceEpoch(json["date_last_edited"]),
        isSelected: false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        'content': content,
        'is_archived': is_archived,
        'date_last_edited': epochFromDate(date_last_edited),
        'color': color,
        'isSelected': isSelected,
      };

  epochFromDate(DateTime dt) {
    return dt.millisecondsSinceEpoch ~/ 1000;
  }
}
