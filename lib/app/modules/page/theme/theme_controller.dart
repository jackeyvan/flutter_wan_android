import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';
import 'package:flutter_wan_android/core/theme/theme_model.dart';
import 'package:flutter_wan_android/core/theme/themes.dart';

class ThemeController extends GetRefreshListController<ThemeModel> {
  late String theme;

  late ThemeMode themeMode;

  @override
  void onInit() {
    theme = AppTheme.readTheme();
    themeMode = AppTheme.readThemeMode();

    super.onInit();
  }

  @override
  Future<List<ThemeModel>> loadListData(int page, bool isRefresh) {
    return Future.value(AppTheme.themes);
  }

  void onItemClick(ThemeModel model) {
    int index = data.indexOf(model);

    /// 前三个是设置模式
    if (index < 3 && model.mode != null) {
      themeMode = model.mode!;
    }

    model.mode = themeMode;
    theme = model.name;

    AppTheme.changeTheme(model);
    showSuccessPage();
  }

  bool isSelected(String name) {
    return theme == name;
  }
}
