import 'package:delau/design/theme.dart';
import 'package:delau/widget/alerts/bottomAlerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen {
  static getNoConnectionScreen(
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35),
        Container(
            height: 200, child: SvgPicture.asset('assets/svg/no-connect.svg')),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Expanded(
              child: Text(
            "Неполучается подключиться к интернету. Проверьте подключение к интернету.",
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
          )),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  static getErrorScreen(
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35),
        Container(
            height: 200, child: SvgPicture.asset('assets/svg/bug_fixing.svg')),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Expanded(
              child: Text(
            "Произошла ошибка. Мы уже работаем над этим. Приходите чуть-чуть позже.",
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
          )),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  static getNoTasksScreen(
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35),
        Container(
            height: 200, child: SvgPicture.asset('assets/svg/calendar.svg')),
        SizedBox(height: 10),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Expanded(
                child: Text(
              "На этот день у вас нет задачь. Хотите добавить ?",
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ))),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(
            right: 0.23 * MediaQuery.of(context).size.width,
            left: 0.23 * MediaQuery.of(context).size.width,
          ),
          child: Container(
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: () {
                getTaskCreateAlert(context, 1, DateTime.now());
              },
              color: DesignTheme.mainColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 12, left: 16.0, right: 16.0, bottom: 12),
                child: Text(
                  "Добавить",
                  style: DesignTheme.buttons.text,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static getNoMarkerScreen(
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35),
        Container(
            height: 200, child: SvgPicture.asset('assets/svg/marker.svg')),
        SizedBox(height: 10),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Expanded(
                child: Text(
              "У вас нет задачь, помеченных маркерами. Хотите добавить ?",
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ))),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(
            right: 0.23 * MediaQuery.of(context).size.width,
            left: 0.23 * MediaQuery.of(context).size.width,
          ),
          child: Container(
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: () {
                getTaskCreateAlert(context, 1, DateTime.now());
              },
              color: DesignTheme.mainColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 12, left: 16.0, right: 16.0, bottom: 12),
                child: Text(
                  "Добавить",
                  style: DesignTheme.buttons.text,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
