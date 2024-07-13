import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/theme_model.dart';
import 'package:flutter_wan_android/app/modules/widget/theme_item_widget.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_page.dart';
import 'package:flutter_wan_android/core/theme/themes.dart';
import 'package:get/get.dart';

import 'theme_controller.dart';

class ThemePage extends GetRefreshPage<ThemeController> {
  const ThemePage({super.key});

  @override
  Widget buildPage() {
    String theme = ThemeController.i.theme.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("主题选择"),
      ),
      body: EasyRefresh(
        controller: controller.refreshController,
        canRefreshAfterNoMore: false,
        canLoadAfterNoMore: false,
        child: ListView(
          children: ThemeModel.themes
              .map((model) => buildItem(model, theme))
              .toList(),
        ),
      ),
    );
  }

  Widget buildItem(var model, var theme) {
    return ListItem(
      title: model.name,
      leading: model.icon == null
          ? Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: model.color,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            )
          : Icon(model.icon),
      divider: false,
      selected: theme == model.name,
      onTap: () {
        if (model.mode != null) {
          AppTheme.changeTheme(AppTheme.dark);
          AppTheme.changeTheme(AppTheme.light);
          AppTheme.changeThemeMode(model.mode!);
        } else if (model.color != null) {
          final themeData = AppTheme.generateTheme(
            brightness: Get.theme.brightness,
            colorSchemeSeed: model.color!,
          );
          AppTheme.changeTheme(themeData);

          AppTheme.changeThemeMode(ThemeMode.light);
        }
        ThemeController.i.theme.value = model.name;
      },
    );
  }
}
