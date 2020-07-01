import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen {
  static getNoConnectionScreen(
    BuildContext context,
  ) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 5),
          Container(
              height: 200,
              child: SvgPicture.asset('assets/svg/no-connect.svg')),
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
      ),
    );
  }

  static getErrorScreen(
    BuildContext context,
  ) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 5),
          Container(
              height: 200,
              child: SvgPicture.asset('assets/svg/bug_fixing.svg')),
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
      ),
    );
  }
}
