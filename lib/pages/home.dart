import 'package:delau/blocs/taskListBloc.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/own_api/prepare/getTasksList.dart';
import 'package:delau/widget/pages/home/appBar.dart';
import 'package:delau/widget/pages/home/futureBuilders.dart';
import 'package:delau/widget/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> carouselChildrens = [];
  List<Task> _taskList;
  var taskListBloc;

  @override
  void initState() {
    getTasksByDate(DateTime.now()).then((taskList) {
      taskListBloc.tasks = taskList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taskListBloc = Provider.of<TaskListBloc>(context);

    return Column(
      children: <Widget>[
        buildAppBar(taskListBloc, _taskList, context),
        taskListBloc.isMarkerOpened ? Container() : buildTabBar(taskListBloc),
        taskListBloc.isMarkerOpened
            ? buildMarkerThemeBaner(taskListBloc)
            : Container(),
        getBody(taskListBloc),
      ],
    );
  }

  Widget getBody(taskListBloc) {
    return taskListBloc.selectedTap == 0
        ? buildListTasks(taskListBloc)
        : taskListBloc.isMarkerOpened
            ? buildListTasks(taskListBloc)
            : buildGridMarkers(taskListBloc);
  }
}
