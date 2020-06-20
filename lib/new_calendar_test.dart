import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delau/widget/bottomSheetAndBar/bottomSheetAndBar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'design/theme.dart';
import 'widget/bottom/bottomBar.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class Calendar extends StatefulWidget {
  Calendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  bool isPlaying = false;
  AnimationController _animationController;
  CalendarController _calendarController;
  double screenHeight;
  double screenWidth;
  AnimationController controller;
  Animation animation;
  bool _selectedIndex;

  _onpressed() {
    setState(() {
      isPlaying = !isPlaying;

      isPlaying ? controller.forward() : controller.reverse();
    });
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this);

    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
      _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
      _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
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

    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      floatingActionButton: FloatingActionButton(
        backgroundColor: DesignTheme.mainColor,
        child: AnimatedIcon(
          icon: AnimatedIcons.add_event,
          progress: controller,
          semanticLabel: 'Show menu',
        ),
        onPressed: () {
          _onpressed();
        },
      ),

      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //TODO: Добавить App Bar
          const SizedBox(height: 25.0),
          _buildTableCalendar(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList(screenWidth, screenHeight)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomSheetAndBar(
          items:[
                  BottomBarItemButton(index:1, selectedIndex:1, icon: FontAwesomeIcons.userAlt, text: "Главная"),
                  BottomBarItemButton(index:2, selectedIndex:1, icon: Icons.calendar_today, text: "Календарь"),
                  BottomBarItemButton(index:3, selectedIndex:1, icon: Icons.settings, text: "Настройки"),
                ],
          ),
        )
      );
    }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'ru_RU',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      availableGestures: AvailableGestures.all,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      initialCalendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: '2 недели',
        CalendarFormat.week: 'Месяц',
        CalendarFormat.twoWeeks: 'Неделя',
      },
      calendarStyle: CalendarStyle(
        selectedColor: DesignTheme.mainColor,
        markersColor: DesignTheme.secondColor,
        outsideDaysVisible: true,
        todayColor: DesignTheme.blueGrey,
        outsideHolidayStyle: TextStyle().copyWith(color: DesignTheme.mainColor),
        holidayStyle: TextStyle().copyWith(color: DesignTheme.mainColor),
        outsideWeekendStyle: TextStyle().copyWith(color: DesignTheme.blueGrey),
        outsideStyle: TextStyle().copyWith(color: DesignTheme.blueGrey),
        weekendStyle: TextStyle().copyWith(color: DesignTheme.mainColor),
      ),
      builders: CalendarBuilders(
              markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          return children;
        },
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: DesignTheme.mainColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: DesignTheme.mainColor, ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? DesignTheme.secondColor
            : DesignTheme.mainColor,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(double _screenWidth, double screenHeight) {
    return  _selectedEvents.length > 0? ListView(
      children:
      _selectedEvents
          .map((event) => Container(
                // margin: EdgeInsets.only(bottom: 20,),
                decoration: BoxDecoration(
                  // border: Border.all(width: 0.8),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [DesignTheme.originalShadowLil],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    ):Column(
      children: <Widget>[
        SizedBox(height:10),
        Container(
          height: screenHeight * 0.25,
          child:SvgPicture.asset('assets/svg/calendar.svg')
        ),
        SizedBox(height:10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Expanded(
              child: Text("На этот день у вас нет задач. Хотите добавить?", overflow: TextOverflow.fade, textAlign: TextAlign.center,)
            ),
        ),
        SizedBox(height:10),
        Container(
          child: RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            onPressed: () {
              print("login");
            },
            color: DesignTheme.mainColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 16.0, right: 16.0, bottom:12),
              child: Text("Добавить", style: DesignTheme.buttons.text,),
            ),
          ),
        ),
      ],
    );
  }
}