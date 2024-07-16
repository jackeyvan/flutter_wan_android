import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/init/themes.dart';
import 'package:flutter_wan_android/core/page/base/base_controller.dart';
import 'package:get/get.dart';

class ThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController());
  }
}

class ThemeController extends BaseController {
  final name = (AppTheme.readTheme() ?? AppTheme.themes[0].name).obs;

  final themeMode = AppTheme.readThemeMode().obs;

  bool isDarkMode = AppTheme.isDarkMode();

  void onItemClick(ThemeModel model) {
    if (model.mode != null) {
      themeMode.value = model.mode!;
      isDarkMode = model.mode! == ThemeMode.dark;
    } else {
      name.value = model.name;
    }

    AppTheme.changeThemeFromModel(model);
  }

  bool isSelected(ThemeModel model) {
    if (model.mode != null) {
      return themeMode.value == model.mode;
    } else {
      return name.value == model.name;
    }
  }

  Color get selectColor {
    return isDarkMode ? Colors.white12 : Colors.black12;
  }
}
