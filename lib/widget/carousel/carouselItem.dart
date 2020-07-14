import 'package:delau/blocs/taskListBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/widget/carousel/carouselHomeSlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Carousel extends StatefulWidget {
  Carousel({this.list});
  List<Task> list;

  @override
  _CarouselState createState() => _CarouselState(list: list);
}

class _CarouselState extends State<Carousel> {
  _CarouselState({this.list});
  List<Task> list;
  var taskListBloc;
  var differenceText;

  getDateDifference(differenceText) {
    final now = DateTime.now();
    final dataDate = taskListBloc.tasks[0].date;
    final differenceInMinutes = dataDate.difference(now).inMinutes;
    if (differenceInMinutes > 60) {
      differenceText = 'Ближайшая истекает через' +
          dataDate.difference(now).inHours.toString() +
          " час.";
    } else {
      differenceText =
          'Ближайшая истекает через' + differenceInMinutes.toString() + " мин.";
    }
    return differenceText;
  }

  @override
  Widget build(BuildContext context) {
    taskListBloc = Provider.of<TaskListBloc>(context);
    if (taskListBloc.isDataLoaded) {
      if (taskListBloc.tasks.length > 0) {
        differenceText = getDateDifference(differenceText);
      } else {
        differenceText = "Распишите свои планы на этот день";
      }
    }

    return Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: CarouselHomeSlider(childrens: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      color: DesignTheme.mainColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: !taskListBloc.isDataLoaded
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              taskListBloc.tasks.length < 10
                                  ? " ${taskListBloc.tasks.length} "
                                  : "${taskListBloc.tasks.length}",
                              style: DesignTheme.biggerWhite
                                  .copyWith(fontSize: 35)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: !taskListBloc.isDataLoaded
                      ? Container(
                          width: MediaQuery.of(context).size.height / 4,
                          child: LinearProgressIndicator())
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Задач на сегодня",
                              style: DesignTheme.carouselLabel,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("$differenceText",
                                style: DesignTheme.carouselUnderLabel,
                                overflow: TextOverflow.fade)
                          ],
                        ),
                ),
              ],
            ),
          )
        ]));
  }
}
