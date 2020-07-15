import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';

Container buildTabButton(int index, String text, IconData icon, taskListBloc) {
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

Container buildReturnBackButton(
    int index, String text, IconData icon, taskListBloc) {
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
