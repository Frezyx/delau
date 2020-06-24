import 'package:bottom_bar_with_sheet/bottom_bar_withs_sheet.dart';
import 'package:delau/blocs/listItemBloc.dart';
import 'package:delau/models/task.dart';
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
  _CalendarState createState() => _CalendarState(isOpen:isOpen);
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  _CalendarState({this.isOpen});

  Map<DateTime, List> _events;
  List _selectedEvents;
  bool isPlaying;
  AnimationController _animationController;
  CalendarController _calendarController;
  double screenHeight;
  double screenWidth;
  AnimationController controller;
  Animation animation;
  int _selectedIndex = 1;
  bool isOpen;

  @override
  void initState() {
    super.initState();

    controller = AnimationController( duration: const Duration(milliseconds: 500), vsync: this);

    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 4)): [Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event A5'), Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event B5'), Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event C5')],
      _selectedDay.subtract(Duration(days: 2)): [Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event A6'), Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event B6')],
      
      _selectedDay: [
        Task(isChecked: true, icon:"wifi", isOpen: false, description: 'Сайт рыбатекст поможет дизайнеру, верстальщику, вебмастеру сгенерировать несколько абзацев более менее осмысленного текста рыбы' , name: 'Пойти выбросить мусор', dateTime: _selectedDay),
        Task(isChecked: false, isOpen: false, icon:"cart", description: 'Сайт рыбатекст поможет дизайнеру, верстальщику, вебмастеру сгенерировать несколько абзацев более менее осмысленного текста рыбы Сайт рыбатекст поможет дизайнеру, верстальщику, вебмастеру сгенерировать несколько абзацев более менее осмысленного текста рыбы', name:"Задачи на сайте", dateTime: _selectedDay), 
        Task(isChecked: false, isOpen: false, icon:"calendar", description: 'Сайт', name: 'Купить хлеба', dateTime: _selectedDay), 
        Task(isChecked: false, isOpen: false, icon:"circle", description: 'Сайт верстальщику, вебмастеру сгенерировать несколько абзацев более', name: 'Позвонить Марине и рассказать за жизнь', dateTime: _selectedDay)
       ],
      
      _selectedDay.add(Duration(days: 1)): [Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event A8'), Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event B8'), Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event C8'), Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event D8')],
      _selectedDay.add(Duration(days: 7)): [Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event A10'), Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event B10'), Task(isChecked: false, isOpen: false, icon:"wifi", name: 'Event C10')],
      };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {

    setState((){
      screenHeight = MediaQuery.of(context).size.height;
      screenWidth = MediaQuery.of(context).size.width;
    });

    final listItemBlocState = Provider.of<ListItemBloc>(context);
    listItemBlocState.selectedEvents = _selectedEvents;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 25.0),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: buildTableCalendar(_calendarController, _events, _holidays, _onDaySelected, _onVisibleDaysChanged, _onCalendarCreated)
          ),
          MultiProvider(
            providers: [Provider<bool>.value(value: widget.isOpen)],
            child: buildEventList(screenWidth, screenHeight, listItemBlocState, _selectedEvents, context)
          )
        ],
      ),
    );
  }
}