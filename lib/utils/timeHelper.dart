import 'package:flutter/material.dart';

getMonthManeByNum(int mounthNumber) {
  var month = "";
  switch (mounthNumber) {
    case (1):
      month = "Января";
      break;
    case (2):
      month = "Февраля";
      break;
    case (3):
      month = "Марта";
      break;
    case (4):
      month = "Апреля";
      break;
    case (5):
      month = "Мая";
      break;
    case (6):
      month = "Июня";
      break;
    case (7):
      month = "Июля";
      break;
    case (8):
      month = "Агуста";
      break;
    case (9):
      month = "Сентября";
      break;
    case (10):
      month = "Октября";
      break;
    case (11):
      month = "Ноября";
      break;
    case (12):
      month = "Декабря";
      break;

    default:
      "error";
  }

  return month;
}

getDayNameByNum(int dayNum) {
  var day = "";
  switch (dayNum) {
    case (1):
      day = "Понедельник";
      break;
    case (2):
      day = "Вторник";
      break;
    case (3):
      day = "Среда";
      break;
    case (4):
      day = "Четверг";
      break;
    case (5):
      day = "Пятница";
      break;
    case (6):
      day = "Суббота";
      break;
    case (7):
      day = "Воскресенье";
      break;

    default:
      "error";
  }

  return day;
}
