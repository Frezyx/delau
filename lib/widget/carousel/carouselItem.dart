import 'package:delau/design/theme.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/own_api/prepare/getTasksList.dart';
import 'package:flutter/material.dart';

class CarouselItem {
  CarouselItem._();

  static final CarouselItem ci = CarouselItem._();

  Widget createMainStatsSlide() {
    // var tasks = await getTasks(4);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: DesignTheme.mainColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("12",
                    style: DesignTheme.biggerWhite.copyWith(fontSize: 35)),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Задач на сегодня",
                  style: DesignTheme.carouselLabel,
                  overflow: TextOverflow.ellipsis,
                ),
                Text("Ближайшая истекает через 40 минут",
                    style: DesignTheme.carouselUnderLabel,
                    overflow: TextOverflow.fade)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
