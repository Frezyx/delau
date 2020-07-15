import 'package:delau/design/theme.dart';
import 'package:delau/models/marker.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'package:delau/widget/starWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
            child: buildItemBody(data, i, context),
          ),
        ),
      ],
    ),
  );
}

Widget buildItemBody(data, int i, context) {
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
                    // Make ListRebuild
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

Card buildGridMarkerItem(List<Marker> data, int i, taskListBloc) {
  return Card(
      shadowColor: Colors.black.withOpacity(0.15),
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
            taskListBloc.openMarker(data[i].name, data[i].icon);
          },
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(MdiIcons.fromString('${data[i].icon}'),
                  color: DesignTheme.mainColor),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text('${data[i].name}', style: DesignTheme.themeText),
              )
            ],
          )));
}
