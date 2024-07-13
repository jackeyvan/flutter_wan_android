import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/theme_model.dart';
import 'package:flutter_wan_android/app/modules/widget/theme_item_widget.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_page.dart';

import 'theme_controller.dart';

class ThemePage extends GetRefreshPage<ThemeController> {
  const ThemePage({super.key});

  @override
  Widget buildPage() {
    return Scaffold(
        appBar: AppBar(
          title: const Text("主题选择"),
        ),
        body: buildObx(
            builder: () => EasyRefresh(
                  controller: controller.refreshController,
                  canRefreshAfterNoMore: false,
                  canLoadAfterNoMore: false,
                  child: ListView(
                    children: ThemeModel.themes
                        .map((model) => buildItem(model))
                        .toList(),
                  ),
                )));
  }

  Widget buildItem(ThemeModel model) {
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
      selected: controller.isSelected(model.name),
      onTap: () => controller.onItemClick(model),
    );
  }
}
