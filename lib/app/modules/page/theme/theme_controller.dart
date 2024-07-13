import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/theme_model.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';
import 'package:flutter_wan_android/core/theme/themes.dart';
import 'package:get/get.dart';

class ThemeController extends GetRefreshListController {
  final theme = 'System'.obs;

  ThemeModel get themeModel =>
      ThemeModel.themes.firstWhere((element) => element.name == theme.value,
          orElse: () => ThemeModel.themes.first);

  @override
  Future<List<ThemeModel>> loadListData(int page, bool isRefresh) {
    return Future.value(ThemeModel.themes);
  }

  void onItemClick(ThemeModel model) {
    if (model.mode != null) {
      AppTheme.changeThemeMode(model.mode!);
    } else if (model.color != null) {
      final themeData = AppTheme.generateTheme(
        brightness: Get.theme.brightness,
        colorSchemeSeed: model.color!,
      );
      AppTheme.changeTheme(themeData);

      AppTheme.changeThemeMode(ThemeMode.light);
    }
    theme.value = model.name;

    showSuccessPage();
  }

  bool isSelected(String name) {
    return theme.value == name;
  }
}
