import 'package:delau/design/theme.dart';
import 'package:delau/utils/timeHelper.dart';
import 'package:delau/widget/carousel/carouselItem.dart';
import 'package:delau/widget/pages/home/home.dart';
import 'package:flutter/material.dart';

Stack buildAppBar(taskListBloc, taskList, context) {
  var date = DateTime.now();
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(0),
        constraints: BoxConstraints.expand(height: 160),
        decoration: BoxDecoration(
            color: DesignTheme.mainColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: Padding(
          padding: EdgeInsets.only(
            top: 45,
            left: 20,
            right: 20,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(date.day.toString(),
                                style: DesignTheme.biggerWhite),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(getDayNameByNum(date.weekday),
                                      style: DesignTheme.midleWhiteBold),
                                  Text(
                                      getMonthManeByNum(date.month) +
                                          " " +
                                          date.year.toString(),
                                      style: DesignTheme.midleWhiteLight),
                                ],
                              ),
                            ),
                          ],
                        ),
                        getPhoto(context),
                      ],
                    )),
              ]),
        ),
      ),
      taskListBloc.isDataLoaded
          ? Carousel()
          : Padding(
              padding: const EdgeInsets.only(top: 140.0),
              child: Expanded(
                child: Container(
                    height: 100,
                    child: Center(child: CircularProgressIndicator())),
              ),
            ),
    ],
  );
}
