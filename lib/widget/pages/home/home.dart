import 'package:delau/design/theme.dart';
import 'package:delau/widget/buttons/tabButtons.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

getPhoto(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, "/userPage");
    },
    child: Container(
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
    ),
  );
}

Padding buildTabBar(taskListBloc) {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildTabButton(0, "Список", Icons.menu, taskListBloc),
          buildTabButton(1, "Темы  ", Icons.border_all, taskListBloc),
        ]),
  );
}

Column buildMarkerThemeBaner(taskListBloc) {
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
            buildReturnBackButton(1, "Назад  ", Icons.arrow_back, taskListBloc),
          ],
        ),
      ),
    ],
  );
}
