import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

getNoTasksScreen(
  double screenHeight,
  BuildContext context,
) {
  return Expanded(
    child: ListView(
      children: <Widget>[
        SizedBox(height: 5),
        Container(
            height: screenHeight * 0.23,
            child: SvgPicture.asset('assets/svg/calendar.svg')),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Expanded(
              child: Text(
            "На этот день у вас нет задач. Хотите добавить?",
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
          )),
        ),
        SizedBox(height: 10),
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
              onPressed: () {},
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
    ),
  );
}
