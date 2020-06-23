class Task {
  String name;
  String description;
  bool isOpen;
  bool isChecked;
  String icon;
  DateTime dateTime;

  Task({
    this.name,
    this.description,
    this.isOpen,
    this.isChecked,
    this.icon,
    this.dateTime,
  });

}

  // var formatter = new DateFormat('Hm');
  // String formatted = formatter.format(_selectedDay);
  // print(formatted);
