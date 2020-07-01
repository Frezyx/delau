import 'package:flutter/material.dart';

class RadioModel {
  int index;
  bool isSelected;
  final IconData icon;
  final String text;

  RadioModel(this.index, this.isSelected, this.icon, this.text);
}