import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorUtils {
  /// Generate background color from string.
  static Color backgroundColorWithString(String value) {
    final strHex =
        hex.encode('${value}color'.codeUnits.map((e) => e % 256).toList());
    String colorStr = '';
    const hexLength = 6;
    final spacing = strHex.length ~/ hexLength;
    for (int i = 0; i < hexLength; i++) {
      colorStr += String.fromCharCode(strHex.codeUnitAt(i * spacing + 1));
    }
    return Color(int.parse('ff$colorStr', radix: 16));
  }

  /// Generate foreground color from string.
  static Color foregroundColorWithString(String value) {
    final bgColor = backgroundColorWithString(value);
    return bgColor.red * 0.299 + bgColor.green * 0.587 + bgColor.blue * 0.114 >
            186
        ? Colors.black
        : Colors.white;
  }
}

class ThemeModel {
  final String name;
  final Color? color;
  final ThemeMode? mode;
  final IconData? icon;

  const ThemeModel({
    required this.name,
    this.color,
    this.mode,
    this.icon,
  });

  static final themes = [
    ThemeModel(
      name: 'System',
      mode: ThemeMode.system,
      icon: GetPlatform.isMobile ? Icons.phone_android : Icons.computer,
    ),
    const ThemeModel(
      name: 'Light',
      mode: ThemeMode.light,
      icon: Icons.light_mode,
    ),
    const ThemeModel(
      name: 'Dark',
      mode: ThemeMode.dark,
      icon: Icons.dark_mode,
    ),
    const ThemeModel(
      name: 'Blue',
      color: Colors.blue,
    ),
    const ThemeModel(
      name: 'Red',
      color: Colors.red,
    ),
    const ThemeModel(
      name: 'Pink',
      color: Colors.pink,
    ),
    const ThemeModel(
      name: 'Purple',
      color: Colors.purple,
    ),
    const ThemeModel(
      name: 'DeepPurple',
      color: Colors.deepPurple,
    ),
    const ThemeModel(
      name: 'Indigo',
      color: Colors.indigo,
    ),
    const ThemeModel(
      name: 'LightBlue',
      color: Colors.lightBlue,
    ),
    const ThemeModel(
      name: 'Cyan',
      color: Colors.cyan,
    ),
    const ThemeModel(
      name: 'Teal',
      color: Colors.teal,
    ),
    const ThemeModel(
      name: 'LightGreen',
      color: Colors.lightGreen,
    ),
    const ThemeModel(
      name: 'Lime',
      color: Colors.lime,
    ),
    const ThemeModel(
      name: 'Yellow',
      color: Colors.yellow,
    ),
    const ThemeModel(
      name: 'Amber',
      color: Colors.amber,
    ),
    const ThemeModel(
      name: 'Orange',
      color: Colors.orange,
    ),
    const ThemeModel(
      name: 'DeepOrange',
      color: Colors.deepOrange,
    ),
    const ThemeModel(
      name: 'Brown',
      color: Colors.brown,
    ),
    const ThemeModel(
      name: 'Grey',
      color: Colors.grey,
    ),
    const ThemeModel(
      name: 'BlueGrey',
      color: Colors.blueGrey,
    ),
  ];
}
