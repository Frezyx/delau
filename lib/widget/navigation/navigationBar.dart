import 'package:bottom_bar_with_sheet/bottom_bar_withs_sheet.dart';
import 'package:delau/blocs/listItemBloc.dart';
import 'package:delau/blocs/notesListBloc.dart';
import 'package:delau/blocs/taskListBloc.dart';
import 'package:delau/pages/calendar.dart';
import 'package:delau/pages/home.dart';
import 'package:delau/pages/notes.dart';
import 'package:delau/widget/navigation/sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBarWithSheetNavigator extends StatefulWidget {
  BottomBarWithSheetNavigator({this.selectedIndex});
  int selectedIndex;

  @override
  _BottomBarWithSheetNavigatorState createState() =>
      _BottomBarWithSheetNavigatorState(selectedIndex: selectedIndex);
}

class _BottomBarWithSheetNavigatorState
    extends State<BottomBarWithSheetNavigator> {
  _BottomBarWithSheetNavigatorState({this.selectedIndex});
  int selectedIndex;

  var pages = [
    ChangeNotifierProvider<TaskListBloc>(
        create: (_) => TaskListBloc(), child: HomePage()),
    ChangeNotifierProvider<ListItemBloc>(
        create: (_) => ListItemBloc(), child: Calendar()),
    ChangeNotifierProvider<NotesListBloc>(
      create: (_) => NotesListBloc(),
      child: Notes(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomBarWithSheet(
        selectedIndex: selectedIndex,
        duration: Duration(milliseconds: 400),
        styleBottomBar: BottomBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          mainActionButtonSize: 55,
          barHeightClosed: 70,
          barHeightOpened: MediaQuery.of(context).size.height / 1.9,
          marginBetweenPanelAndActtionButton: 30,
          rightMargin: 15,
          mainActionButtonPadding: EdgeInsets.all(7),
          mainActionButtonIconClosed: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          mainActionButtonIconOpened: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 35,
          ),
        ),
        onSelectItem: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        sheetChild: SheetOfBottomBar(),
        items: [
          BottomBarWithSheetItem(
            iconData: Icons.people,
            label: 'Главная',
            selectedBackgroundColor: Colors.blue,
          ),
          BottomBarWithSheetItem(
            iconData: Icons.calendar_today,
            label: 'Календарь',
            selectedBackgroundColor: Colors.blue,
          ),
          BottomBarWithSheetItem(
            iconData: Icons.list,
            label: 'Заметки',
            selectedBackgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
