import 'package:delau/design/theme.dart';
import 'package:delau/models/marker.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/templates/radio.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'package:delau/utils/timeHelper.dart';
import 'package:delau/widget/alerts/alertManager.dart';
import 'package:delau/widget/inputs/customRadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:intl/intl.dart';

class AddTaskAlert extends StatefulWidget {
  @override
  _AddTaskAlertState createState() => _AddTaskAlertState();
}

class _AddTaskAlertState extends State<AddTaskAlert> {
  var task = Task();
  var markers = new List<Marker>();
  // List<RadioModel> sampleData = new List<RadioModel>();
  final _formKey = GlobalKey<FormState>();
  var selectedPriority = 0.0;

  TimeOfDay time;
  DateTime date;
  int selectedIconIndex = 0;

  @override
  void initState() {
    markers.add(new Marker(id: 0, name: "Учеба", icon: "book"));
    markers.add(new Marker(id: 0, name: "Учеба", icon: "book"));
    markers.add(new Marker(id: 0, name: "Учеба", icon: "book"));
    markers.add(new Marker(id: 0, name: "Учеба", icon: "book"));

    // sampleData.add(new RadioModel(0, true, FontAwesome.book, 'Учеба'));
    // sampleData.add(new RadioModel(1, false, FontAwesome.briefcase, 'Работа'));
    // sampleData.add(
    //     new RadioModel(2, false, MdiIcons.fromString('basketball'), 'Спорт'));
    // sampleData.add(new RadioModel(3, false, FontAwesome.users, 'Встречи'));
    // sampleData.add(
    //     new RadioModel(4, false, MdiIcons.fromString('shopping'), 'Покупки'));
    // sampleData.add(new RadioModel(5, false, FontAwesome.spinner, 'Другое'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 14.0, top: 4.0, left: 8.0, right: 8.0),
                child: Text(
                  "Добавление задачи",
                  style: DesignTheme.alert.bigText,
                ),
              ),
              buildTitleTextField(),
              SizedBox(height: 5),
              buildDescriptionTextField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildPriorityButton(context),
                  buildTimeButton(context),
                  buildDateButton(context),
                ],
              ),
              buildMarkerPicker(),
              SizedBox(height: 5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getBottomButton(
                        "Отменить", Icons.add, Colors.red, context, true),
                    getBottomButton("Сохранить", Icons.add,
                        DesignTheme.mainColor, context, false),
                  ]),
            ]),
          ),
        ),
      ],
    ));
  }

  getBottomButton(String text, IconData icon, Color color, BuildContext context,
      bool isCloseButton) {
    return Padding(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 20),
        child: OutlineButton(
            hoverColor: Colors.white,
            focusColor: Colors.white,
            highlightColor: Colors.white,
            splashColor: color,
            onPressed: () {
              if (isCloseButton) {
                Navigator.pop(context);
              } else {
                if (_formKey.currentState.validate()) {
                  var realDate = DateTime(date.year, date.month, date.day,
                      time.hour, time.minute, 0, 0, 0);
                  task.date = realDate;
                  // task.time = DateTime.fromMillisecondsSinceEpoch(time);
                  API.taskHandler.createTask(task).then((res) {
                    if (res) {
                      Navigator.popAndPushNamed(context, "/navigator/0");
                    } else {
                      // throw allet
                    }
                  });
                }
              }
              debugPrint(task.toJson().toString());
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: TextStyle(
                            color: color,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
            highlightedBorderColor: color,
            borderSide: new BorderSide(color: color),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(
                    DesignTheme.normalBorderRadius))));
  }

  Container buildMarkerPicker() {
    return Container(
      height: 100.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: markers.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                task.icon = markers[i].icon;
                task.markerID = markers[i].id;
                setState(() {
                  selectedIconIndex = i;
                });
              },
              splashColor: DesignTheme.mainColor,
              child: getCustomRadio(markers, i, selectedIconIndex),
            );
          }),
    );
  }

  Widget buildDescriptionTextField() {
    return TextFormField(
      key: Key('description_task'),
      onTap: () {},
      maxLines: null,
      cursorColor: DesignTheme.mainColor,
      decoration: InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        hintText: "Пояснение задачи",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTheme.normalBorderRadius),
          borderSide: BorderSide(
            style: BorderStyle.solid,
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty)
          return 'Введите пояснение задачи';
        else {
          task.description = value.toString();
        }
      },
    );
  }

  Widget buildTitleTextField() {
    return TextFormField(
      key: Key('title_task'),
      onTap: () {},
      cursorColor: DesignTheme.mainColor,
      decoration: InputDecoration(
        hintText: "Название задачи",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTheme.normalBorderRadius),
          borderSide: BorderSide(
            style: BorderStyle.solid,
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty)
          return 'Введите название задачи';
        else {
          task.name = value.toString();
        }
      },
    );
  }

  Widget buildDateButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignTheme.normalBorderRadius),
        border: Border.all(width: 1, color: DesignTheme.mainColor),
      ),
      child: FlatButton(
        color: Colors.transparent,
        textColor: DesignTheme.mainColor,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        onPressed: () async {
          var getDate = await AlertManager.getDatePickerAlert(context);
          setState(() {
            date = getDate;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.date_range,
              size: 28.0,
            ),
            SizedBox(height: 7),
            Text(
              date == null ? "Дата" : DateFormat('yyyy-MM-dd').format(date),
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignTheme.normalBorderRadius),
        border: Border.all(width: 1, color: DesignTheme.mainColor),
      ),
      child: FlatButton(
        color: Colors.transparent,
        textColor: DesignTheme.mainColor,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        onPressed: () async {
          var getTime = await AlertManager.getTimePickerAlert(context);
          setState(() {
            time = getTime;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.timer,
              size: 28.0,
            ),
            SizedBox(height: 7),
            Text(
              time == null
                  ? "Вермя"
                  : time.hour.toString() + " : " + time.minute.toString(),
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriorityButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignTheme.normalBorderRadius),
        border: Border.all(width: 1, color: DesignTheme.mainColor),
      ),
      child: FlatButton(
        color: Colors.transparent,
        textColor: DesignTheme.mainColor,
        padding: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
        ),
        onPressed: () async {
          getPriorityPicker(context);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.star,
              size: 28.0,
            ),
            SizedBox(height: 7),
            Text(
              selectedPriority == 0 ? "Приоритет" : selectedPriority.toString(),
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPriorityPicker(context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: Text(
                  'Выберете приоритет задачи.',
                  style: TextStyle(fontSize: 20),
                ),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: StarRating(
                      starConfig: StarConfig(
                        size: 28,
                        strokeColor: DesignTheme.mainColor,
                        fillColor: DesignTheme.mainColor,
                      ),
                      rating: selectedPriority,
                      onChangeRating: (int rating) {
                        setState(() {
                          selectedPriority = double.parse(rating.toString());
                        });
                      },
                    ),
                  ),
                  FlatButton(
                    child: Text('Сохранить'),
                    textColor: DesignTheme.mainColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          },
        );
      },
    );
  }
}
