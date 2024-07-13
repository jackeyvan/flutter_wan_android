import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTheme {
  static final light = generateTheme(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.green,
  );

  static final dark = generateTheme(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.green,
  );

  /// TODO 根据不同的颜色，定制不同的主题
  static ThemeData generateTheme({
    required Brightness brightness,
    required Color colorSchemeSeed,
  }) {
    return ThemeData(
        brightness: brightness,
        useMaterial3: true,
        colorSchemeSeed: colorSchemeSeed);
  }

  static changeTheme(ThemeData theme) {
    Get.changeTheme(theme);
  }

  static changeThemeMode(ThemeMode theme) {
    Get.changeThemeMode(theme);
  }
}
