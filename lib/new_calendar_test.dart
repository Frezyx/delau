import 'package:bottom_bar_with_sheet/bottom_bar_withs_sheet.dart';
import 'package:delau/blocs/listItemBloc.dart';
import 'package:delau/models/provider/listItemState.dart';
import 'package:delau/widget/infoIllustratedScreens/noTasks.dart';
import 'package:delau/widget/list_builders/withDate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'design/theme.dart';

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
  int _selectedIndex = 1;


  @override
  void initState() {
    super.initState();

    controller = AnimationController( duration: const Duration(milliseconds: 500), vsync: this);

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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 25.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: _buildTableCalendar()
          ),
          _buildEventList(screenWidth, screenHeight)
        ],
      ),

      bottomNavigationBar: BottomBarWithSheet(
        selectedIndex: _selectedIndex,
        duration: Duration(milliseconds: 400),
        styleBottomBar: BottomBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          mainActionButtonSize: 55,
          barHeightClosed: 70,
          barHeightOpened: 410,
          marginBetweenPanelAndActtionButton: 30,
          rightMargin: 15,
          mainActionButtonPadding: EdgeInsets.all(7),
          mainActionButtonIconClosed: Icon(Icons.add, color:Colors.white , size: 30,),
          mainActionButtonIconOpened: Icon(Icons.keyboard_arrow_down, color:Colors.white, size: 35,),
        ),

        onSelectItem: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        sheetChild: Center(child: Text("Place for your another content")),

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
            iconData: Icons.settings,
            label: 'Настройки',
            selectedBackgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

    openPage(int pageIndex){
      setState((){
        _selectedIndex = pageIndex;
      });
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
    return  _selectedEvents.length > 0? 
     Expanded(
       child: ListView.builder(
        itemCount: _selectedEvents.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          // ListItemBloc itemState = Provider.of<ListItemBloc>(context);
          return 

        // MultiProvider(
        //   providers: [
        //     Provider<TasksListItemState>.value(value: _tasksListItemState),
        // ],
        // child:

        ListTile(
            contentPadding: const EdgeInsets.only(left: 24.0, right: 24),
            title:
              Row(
                children: <Widget>[

                  lineStyle(context, 15, index, _selectedEvents.length, true),
                  displayTime(
                    "12:12"
                  ),
                  InkWell(
                    onTap: () {
                      print(_selectedEvents[index] + "СОСИ !!!");
                      // itemState.isOpen = !itemState.isOpen;
                    },
                    child: ListWithDateItem(listPosition: index, data: _selectedEvents, itemState : null),
                  ),
                ],
              ),
            // ),
          );
        },
    ),
  ) : getNoTasksScreen(screenHeight, context);
  }
}