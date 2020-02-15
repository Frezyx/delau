import 'package:flutter/material.dart';

  determinateTextToDate(DateTime date){
    String dateInString =date.toString();
    String day = dateInString.substring(9,10);
    String year = dateInString.substring(0, 4);
    String month;
    int mounthNumber = int.parse(dateInString.substring(6, 7));
    switch (mounthNumber) {
      case(1):
        month = "Января";
        break;
      case(2):
        month = "Февраля";
        break;
      case(3):
        month = "Марта";
        break;
      case(4):
        month = "Апреля";
        break;
      case(5):
        month = "Мая";
        break;
      case(6):
        month = "Июня";
        break;
      case(7):
        month = "Июля";
        break;
      case(8):
        month = "Агуста";
        break;
      case(9):
        month = "Сентября";
        break;
      case(10):
        month = "Октября";
        break;
      case(11):
        month = "Ноября";
        break;
      case(12):
        month = "Декабря";
        break;

      default: "error";
    }

    return "$day $month $year";
    
  }

  determinateTextToTime(TimeOfDay time){
    return time.toString().substring(10, 15);
  }