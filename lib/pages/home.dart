import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/test_data/testTaskList.dart';
import 'package:delau/widget/carousel/carouselHomeSlider.dart';
import 'package:delau/widget/carousel/carouselItem.dart';
import 'package:delau/widget/starWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTap = 0;
  List<Widget> carouselChildrens = [];

  @override
  void initState() {
    carouselChildrens.add(CarouselItem.ci.createMainStatsSlide());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildAppBar(),
        buildTabBar(),
        getBody(),
      ],
    );
  }

  Widget getBody() {
    return _selectedTap == 0 ? buildListTasks() : buildGridThemes();
  }

  Stack buildAppBar() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints.expand(height: 160),
          decoration: BoxDecoration(
              color: DesignTheme.mainColor,
              // gradient: DesignTheme.gradientButton,
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
                              Text("17", style: DesignTheme.biggerWhite),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("понедельник",
                                        style: DesignTheme.midleWhiteBold),
                                    Text("Август 2020",
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
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: CarouselHomeSlider(
            childrens: carouselChildrens,
          ),
        ),
      ],
    );
  }

  Widget buildGridThemes() {
    return Expanded(
      child: FutureBuilder(
          future: getTestTaskData(),
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Input a URL to start');
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              case ConnectionState.active:
                return new Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return new Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  var count = snapshot.data.length;
                  var data = snapshot.data;
                  return AnimationLimiter(
                      child: StaggeredGridView.countBuilder(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
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
                                          onTap: () {},
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                  MdiIcons.fromString(
                                                      '${data[i].icon}'),
                                                  color: DesignTheme.mainColor),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text("Название",
                                                    style:
                                                        DesignTheme.themeText),
                                              )
                                            ],
                                          ))))));
                    },
                    staggeredTileBuilder: (int index) =>
                        StaggeredTile.count(1, 1),
                  ));
                }
            }
          }),
    );
  }

  Widget buildListTasks() {
    return Expanded(
      child: FutureBuilder(
          future: getTestTaskData(),
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text('Input a URL to start');
              case ConnectionState.waiting:
                return new Center(child: new CircularProgressIndicator());
              case ConnectionState.active:
                return new Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return new Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  var count = snapshot.data.length;
                  var data = snapshot.data;
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
                                        child: buildListItem(i, data))));
                          }));
                }
            }
          }),
    );
  }

  Widget buildListItem(int i, data) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0, left: 17),
            child: Text(
              DateFormat('Hm').format(data[i].date),
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
                StarDisplay(value: 3),
              ],
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Checkbox(
                activeColor: DesignTheme.mainColor,
                onChanged: (bool value) {
                  setState(() {
                    data[i].isChecked = value;
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
    return Container(
      width: 50,
      height: 50,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              fit: BoxFit.cover, image: AssetImage("assets/userEllipse.png"))),
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
    var isOpen = _selectedTap == index;
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
          setState(() {
            _selectedTap = index;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
