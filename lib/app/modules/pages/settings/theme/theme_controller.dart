import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/const/styles.dart';
import 'package:flutter_wan_android/app/modules/base/scaffold_controller.dart';
import 'package:flutter_wan_android/core/init/themes.dart';
import 'package:get/get.dart';

class ThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController());
  }
}

class ThemeController extends ScaffoldController {
  final name = (AppTheme.readTheme() ?? AppTheme.themes[0].name).obs;

  final themeMode = AppTheme.readThemeMode().obs;

  bool isDarkMode = AppTheme.isDarkMode();

  @override
  void setTitle() {
    title = Strings.themeSetting.tr;
  }

  void onItemClick(ThemeModel model) {
    if (model.mode != null) {
      themeMode.value = model.mode!;
      isDarkMode = model.mode! == ThemeMode.dark;
    } else {
      name.value = model.name;
    }

    AppTheme.changeThemeFromModel(model);

    update();
  }

  bool isSelected(ThemeModel model) {
    if (model.mode != null) {
      return themeMode.value == model.mode;
    }

    return name.value == model.name;
  }

  Color get selectColor {
    return isDarkMode ? Colors.white12 : Colors.black12;
  }
}
