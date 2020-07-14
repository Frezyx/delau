import 'package:delau/design/theme.dart';
import 'package:delau/models/marker.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

getCustomRadio(List<Marker> markers, int index, selectedIndex) {
  return new Container(
    margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
    child: new Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Container(
          height: 50.0,
          width: 50.0,
          child: new Center(
            child: new Icon(
              MdiIcons.fromString('${markers[index].icon}'),
              color: index == selectedIndex
                  ? DesignTheme.mainColor
                  : Colors.black26,
            ),
          ),
          decoration: new BoxDecoration(
            color: index == selectedIndex ? Colors.white : Colors.transparent,
            border: new Border.all(
                width: 1.0,
                color: index == selectedIndex
                    ? DesignTheme.mainColor
                    : Colors.black26),
            borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(left: 0.0, top: 4.0),
          child: new Text(
            markers[index].name,
            style: TextStyle(
              color: index == selectedIndex
                  ? DesignTheme.mainColor
                  : Colors.black54,
            ),
          ),
        )
      ],
    ),
  );
}
