import 'package:bottom_bar_with_sheet/bottom_bar_withs_sheet.dart';
import 'package:delau/blocs/listItemBloc.dart';
import 'package:delau/models/task.dart';
import 'package:delau/widget/infoIllustratedScreens/noTasks.dart';
import 'package:delau/widget/list_builders/taskStateIconLine.dart';
import 'package:delau/widget/list_builders/withDate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: _buildTableCalendar()
          ),
          MultiProvider(
          providers: [
            Provider<bool>.value(value: widget.isOpen),
          ],
          child: _buildEventList(screenWidth, screenHeight, listItemBlocState)
          )
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

  Widget _buildEventList(double _screenWidth, double screenHeight, listItemBlocState) {
    return  _selectedEvents.length > 0? 
     Expanded(
       child: ListView.builder(
        itemCount: _selectedEvents.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 24, right: 24),
            title:
              Row(
                children: <Widget>[
                  LineStateCheckedIcons(
                    iconSize: 15,
                    index: index,
                    listLength: _selectedEvents.length,
                    isFinish: true,
                  ),
                  displayTime(
                    DateFormat('Hm').format(listItemBlocState.selectedEvents[index].dateTime)
                  ),
                  GestureDetector(
                    onTap: () {
                      listItemBlocState.changeOpenState(index);
                    },
                    child: ListWithDateItem(listPosition: index, data: _selectedEvents),
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