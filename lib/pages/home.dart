import 'package:carousel_slider/carousel_slider.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/test_data/testTaskList.dart';
import 'package:delau/widget/pages/carouselHomeSlider.dart';
import 'package:delau/widget/starWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedTap = 0;

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

  Widget getBody(){
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
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 45, left: 20,right: 20,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[

                  Padding(
                    padding: EdgeInsets.only(left: 15,right: 15,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("17", style: DesignTheme.biggerWhite),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("понедельник", style: DesignTheme.midleWhiteBold),
                                  Text("Август 2020", style: DesignTheme.midleWhiteLight),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ]),
                ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: CarouselHomeSlider(),
            ),
          ],
        );
  }

  Text buildGridThemes() => Text("Grid");

  Expanded buildListTasks() {
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
                    return ListView.builder(
                      itemCount: count,
                      itemBuilder: (context, i) {
                        return buildListItem(i, data);
                      });
                  }
                }
              }
            ),
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
              DateFormat('Hm').format(data[i].dateTime),
              style: DesignTheme.itemTime,
            ),
          ),
          Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 15, right: 15),
                    child: buildItemBody(data, i),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildItemBody(data, int i){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(MdiIcons.fromString('${data[i].icon}'), color: DesignTheme.mainColor),
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
                  child: Text(
                    data[i].name, 
                    style:DesignTheme.bigItemLabel,
                    overflow: TextOverflow.ellipsis
                  )
                ),
              ),
              SizedBox(height: 3,),
              Expanded(
                  child: Text(
                    data[i].description, 
                    style:DesignTheme.lilItemLabel,
                    overflow: TextOverflow.fade
                  )
              ),
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

                        },
                      value: false,
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Padding buildTabBar() {
    return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildTabButton(0, "Список", Icons.menu),
              buildTabButton(1, "Группы", Icons.border_all),
            ]
          ),
        );
      }

  Container buildTabButton(int index, String text, IconData icon) {
    var isOpen = _selectedTap == index;
    return Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(30.0),
            boxShadow: isOpen ? DesignTheme.buttons.selectedTabHomeShadow : DesignTheme.buttons.tabHomeShadow,
          ),
          child: RaisedButton(
            elevation: 0,
            color: isOpen ? DesignTheme.mainColor : Colors.white,
            child: Row(
              children: <Widget>[
                Icon(icon, color: isOpen ? Colors.white : Colors.black ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(text, style: isOpen ? DesignTheme.buttons.selectedTabText : DesignTheme.buttons.tabText),
                ),
              ],
            ),
            onPressed: () {
              setState((){
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