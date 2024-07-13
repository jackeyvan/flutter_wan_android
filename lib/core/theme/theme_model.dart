import 'package:flutter/material.dart';

class ThemeModel {
  String name;
  Color? color;
  ThemeMode? mode;
  IconData? icon;

  ThemeModel({
    required this.name,
    this.color,
    this.mode,
    this.icon,
  });
}
