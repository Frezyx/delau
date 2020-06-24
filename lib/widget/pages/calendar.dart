
import 'package:delau/design/theme.dart';
import 'package:delau/widget/infoIllustratedScreens/noTasks.dart';
import 'package:delau/widget/list_builders/taskStateIconLine.dart';
import 'package:delau/widget/list_builders/withDate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

  Widget buildTableCalendar(_calendarController, _events, _holidays, _onDaySelected, _onVisibleDaysChanged, _onCalendarCreated) {
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
                child: buildEventsMarker(date, events, _calendarController),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: buildEventsMarker(date, events, _calendarController),
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

  Widget buildEventsMarker(DateTime date, List events, _calendarController) {
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

  Widget buildEventList(double _screenWidth, double screenHeight, listItemBlocState, _selectedEvents, context) {
    return  _selectedEvents.length > 0? 
     Expanded(
       child: ListView.builder(
        itemCount: _selectedEvents.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          //TODO: Сделать так, чтоб только контейнер можно было двигать
          return  Dismissible(
                  key: UniqueKey(),
                  background: Container(),
          child:        
          ListTile(
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
            )
          );
        },
    ),
  ) : getNoTasksScreen(screenHeight, context);
  }