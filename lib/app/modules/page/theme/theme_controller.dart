import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/page/base/base_controller.dart';
import 'package:flutter_wan_android/core/theme/theme_model.dart';
import 'package:flutter_wan_android/core/theme/themes.dart';

class ThemeController extends BaseController {
  late String name;

  late ThemeMode themeMode;

  bool isDarkMode = AppTheme.isDarkMode();

  @override
  void onInit() {
    name = AppTheme.readTheme() ?? AppTheme.themes[0].name;
    themeMode = AppTheme.readThemeMode();

    showSuccessPage();
    super.onInit();
  }

  void onItemClick(ThemeModel model) {
    if (model.mode != null) {
      themeMode = model.mode!;
      isDarkMode = model.mode! == ThemeMode.dark;
    } else {
      name = model.name;
    }

    AppTheme.changeThemeFromModel(model);
    showSuccessPage();
  }

  bool isSelected(ThemeModel model) {
    if (model.mode != null) {
      return themeMode == model.mode;
    } else {
      return name == model.name;
    }
  }

  Color get selectColor {
    return isDarkMode ? Colors.white12 : Colors.black12;
  }
}
