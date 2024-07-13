import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/theme_model.dart';
import 'package:get/get.dart';

class AppThemeBackup {
  static final light = generateTheme(brightness: Brightness.light);

  static final dark = generateTheme(brightness: Brightness.dark);

  static ThemeData generateTheme({
    required Brightness brightness,
    Color? colorSchemeSeed,
  }) {
    return ThemeData(
        brightness: brightness,
        useMaterial3: true,
        colorSchemeSeed: colorSchemeSeed);
  }

  static changeTheme(ThemeData theme) {
    /// GetX的Bug，黑夜模式下，用暴露的方法改不了，调用底层方法啊
    if (Get.isDarkMode) {
      Get.rootController.darkTheme = theme;
    }

    Get.changeTheme(theme);
  }

  static changeThemeMode(ThemeMode theme) {
    if (theme == ThemeMode.dark) {
      changeTheme(dark);
    } else {
      changeTheme(light);
    }
    Get.changeThemeMode(theme);
  }

  static final themeModes = [
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
  ];

  static final themeColors = [
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
