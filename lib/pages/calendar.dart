import 'package:bottom_bar_with_sheet/bottom_bar_withs_sheet.dart';
import 'package:delau/blocs/listItemBloc.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'package:delau/utils/provider/own_api/prepare/getTasksList.dart';
import 'package:delau/widget/infoIllustratedScreens/noTasks.dart';
import 'package:delau/widget/list_builders/taskStateIconLine.dart';
import 'package:delau/widget/list_builders/withDate.dart';
import 'package:delau/widget/pages/calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'package:delau/design/theme.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class Calendar extends StatefulWidget {
  Calendar({Key key, this.isOpen = false}) : super(key: key);

  bool isOpen;

  @override
  _CalendarState createState() => _CalendarState(isOpen: isOpen);
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  _CalendarState({this.isOpen});
  bool isPlaying;
  AnimationController _animationController;
  CalendarController _calendarController;
  double screenHeight;
  double screenWidth;
  AnimationController controller;
  Animation animation;
  bool isOpen;
  var listItemBlocState;
  DateTime _selectedDay;

  @override
  void initState() {
    _selectedDay = DateTime.now();
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    listItemBlocState.selectEvents(day);
    setState(() {
      _selectedDay = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenHeight = MediaQuery.of(context).size.height;
      screenWidth = MediaQuery.of(context).size.width;
    });

    listItemBlocState = Provider.of<ListItemBloc>(context);
    listItemBlocState.loadEvents(4);

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 25.0),
          Container(
              decoration: BoxDecoration(color: Colors.white),
              child: buildTableCalendar(
                  _calendarController,
                  listItemBlocState,
                  _holidays,
                  _onDaySelected,
                  _onVisibleDaysChanged,
                  _onCalendarCreated)),
          // Expanded(
          //   child: Container(
          //     height: double.infinity,
          //     child:
          MultiProvider(
              providers: [Provider<bool>.value(value: widget.isOpen)],
              child: buildEventList(screenWidth, screenHeight,
                  listItemBlocState, _selectedDay, context)),
          //   ),
          // )
        ],
      ),
    );
  }
}
