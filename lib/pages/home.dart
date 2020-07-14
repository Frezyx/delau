import 'package:delau/blocs/taskListBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/models/marker.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'package:delau/utils/provider/own_api/prepare/getMarkersList.dart';
import 'package:delau/utils/provider/own_api/prepare/getTasksList.dart';
import 'package:delau/utils/timeHelper.dart';
import 'package:delau/widget/carousel/carouselItem.dart';
import 'package:delau/widget/infoIllustratedScreens/infoscreens.dart';
import 'package:delau/widget/pages/home/home.dart';
import 'package:delau/widget/starWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
        buildAppBar(),
        taskListBloc.isMarkerOpened ? Container() : buildTabBar(),
        taskListBloc.isMarkerOpened ? buildMarkerThemeBaner() : Container(),
        getBody(taskListBloc),
      ],
    );
  }

  Column buildMarkerThemeBaner() {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(MdiIcons.fromString('${taskListBloc.markerIcon}'),
                      color: DesignTheme.mainColor),
                  SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        transform: Matrix4.translationValues(0.0, 2.0, 0.0),
                        child: Text("Тема:",
                            style: DesignTheme.markerThemeFieldText),
                      ),
                      Text(taskListBloc.marker,
                          style: DesignTheme.markerThemeText),
                    ],
                  ),
                ],
              )),
              buildReturnBackButton(1, "Назад  ", Icons.arrow_back),
            ],
          ),
        ),
      ],
    );
  }

  Widget getBody(taskListBloc) {
    return taskListBloc.selectedTap == 0
        ? buildListTasks()
        : taskListBloc.isMarkerOpened ? buildListTasks() : buildGridMarkers();
  }

  Stack buildAppBar() {
    var date = DateTime.now();
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints.expand(height: 160),
          decoration: BoxDecoration(
              color: DesignTheme.mainColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40))),
          child: Padding(
            padding: EdgeInsets.only(
              top: 45,
              left: 20,
              right: 20,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(date.day.toString(),
                                  style: DesignTheme.biggerWhite),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(getDayNameByNum(date.weekday),
                                        style: DesignTheme.midleWhiteBold),
                                    Text(
                                        getMonthManeByNum(date.month) +
                                            " " +
                                            date.year.toString(),
                                        style: DesignTheme.midleWhiteLight),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          getPhoto(),
                        ],
                      )),
                ]),
          ),
        ),
        taskListBloc.isDataLoaded
            ? Carousel(list: _taskList)
            : Padding(
                padding: const EdgeInsets.only(top: 140.0),
                child: Expanded(
                  child: Container(
                      height: 100,
                      child: Center(child: CircularProgressIndicator())),
                ),
              ),
      ],
    );
  }

  Widget buildGridMarkers() {
    return Expanded(
      child: FutureBuilder(
          future: getMarkersList(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return InfoScreen.getNoConnectionScreen(context);
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              case ConnectionState.active:
                return new Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return InfoScreen.getErrorScreen(context);
                } else {
                  var count = snapshot.data.length;
                  var data = snapshot.data;
                  if (count == 0) {
                    return InfoScreen.getNoMarkerScreen(context);
                  } else {
                    return AnimationLimiter(
                        child: StaggeredGridView.countBuilder(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      itemCount: count,
                      itemBuilder: (context, i) {
                        return AnimationConfiguration.staggeredGrid(
                            position: i,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 3,
                            child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                    child: Card(
                                        shadowColor:
                                            Colors.black.withOpacity(0.15),
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        color: Colors.white,
                                        child: InkWell(
                                            highlightColor: Colors.white,
                                            hoverColor: DesignTheme.mainColor,
                                            focusColor: DesignTheme.mainColor,
                                            splashColor: DesignTheme.mainColor,
                                            onLongPress: () {},
                                            onTap: () {
                                              taskListBloc.openMarker(
                                                  data[i].name, data[i].icon);
                                            },
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                    MdiIcons.fromString(
                                                        '${data[i].icon}'),
                                                    color:
                                                        DesignTheme.mainColor),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Text('${data[i].name}',
                                                      style: DesignTheme
                                                          .themeText),
                                                )
                                              ],
                                            ))))));
                      },
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.count(1, 1),
                    ));
                  }
                }
            }
          }),
    );
  }

  Widget buildListTasks() {
    return Expanded(
        child: Container(
      height: double.infinity,
      child: FutureBuilder(
          // future: getTasks(4),
          future: taskListBloc.isMarkerOpened
              ? getTasksByMarker(taskListBloc.marker)
              : getTasksByDate(DateTime.now()),
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return InfoScreen.getNoConnectionScreen(context);
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              case ConnectionState.active:
                return new Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return InfoScreen.getErrorScreen(context);
                } else {
                  var count = snapshot.data.length;
                  var data = snapshot.data;
                  if (count == 0) {
                    return InfoScreen.getNoTasksScreen(context);
                  } else {
                    return AnimationLimiter(
                        child: ListView.builder(
                            itemCount: count,
                            itemBuilder: (context, i) {
                              return AnimationConfiguration.staggeredList(
                                  position: i,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                          child: buildListItem(
                                              i, data, context))));
                            }));
                  }
                }
            }
          }),
    ));
  }

  Widget buildListItem(int i, data, context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0, left: 17),
            child: Text(
              DateFormat('HH:mm').format(data[i].date),
              style: DesignTheme.itemTime,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 20.0,
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 15, right: 15),
              child: buildItemBody(data, i),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemBody(data, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(MdiIcons.fromString('${data[i].icon}'),
            color: DesignTheme.mainColor),
        Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 16,
                  child: Expanded(
                      child: Text(data[i].name,
                          style: DesignTheme.bigItemLabel,
                          overflow: TextOverflow.ellipsis)),
                ),
                SizedBox(
                  height: 3,
                ),
                Expanded(
                    child: Text(data[i].description,
                        style: DesignTheme.lilItemLabel,
                        overflow: TextOverflow.fade)),
                StarDisplay(value: data[i].rating ~/ 1),
              ],
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Checkbox(
                activeColor: DesignTheme.mainColor,
                onChanged: (bool value) {
                  API.taskHandler.checkTask(data[i].id).then((res) {
                    if (res) {
                      setState(() {});
                    }
                  });
                },
                value: data[i].isChecked,
              ),
            ),
          ],
        ),
      ],
    );
  }

  getPhoto() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/userPage");
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: new BoxDecoration(
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/userEllipse.png"))),
        child: Container(
          margin: EdgeInsets.all(1),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(
                    "https://avatars.mds.yandex.net/get-pdb/1779125/deed738a-66f5-46d0-b3c6-020dff434219/s1200")),
          ),
        ),
      ),
    );
  }

  Padding buildTabBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildTabButton(0, "Список", Icons.menu),
            buildTabButton(1, "Темы  ", Icons.border_all),
          ]),
    );
  }

  Container buildTabButton(int index, String text, IconData icon) {
    var isOpen = taskListBloc.selectedTap == index;
    return Container(
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(30.0),
        boxShadow: isOpen
            ? DesignTheme.buttons.selectedTabHomeShadow
            : DesignTheme.buttons.tabHomeShadow,
      ),
      child: RaisedButton(
        elevation: 0,
        color: isOpen ? DesignTheme.mainColor : Colors.white,
        child: Row(
          children: <Widget>[
            Icon(icon, color: isOpen ? Colors.white : DesignTheme.greyDark),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(text,
                  style: isOpen
                      ? DesignTheme.buttons.selectedTabText
                      : DesignTheme.buttons.tabText),
            ),
          ],
        ),
        onPressed: () {
          taskListBloc.closeMarker();
          taskListBloc.selectedTap = index;
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  Container buildReturnBackButton(int index, String text, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(30.0),
          boxShadow: DesignTheme.buttons.tabHomeShadow),
      child: RaisedButton(
        elevation: 0,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Icon(icon, color: DesignTheme.greyDark),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(text, style: DesignTheme.buttons.tabText),
            ),
          ],
        ),
        onPressed: () {
          taskListBloc.closeMarker();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
