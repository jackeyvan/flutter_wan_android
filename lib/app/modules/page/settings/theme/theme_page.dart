import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/base/scaffold_page.dart';
import 'package:flutter_wan_android/app/modules/widget/theme_item_widget.dart';
import 'package:flutter_wan_android/core/init/themes.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'theme_controller.dart';

class ThemePage extends ScaffoldPage<ThemeController> {
  const ThemePage({super.key});

  @override
  Widget buildBodyPage() {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: buildItems(),
    );
  }

  Widget buildItem(ThemeModel model) {
    return Obx(() => ListItem(
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
          selectBgColor: controller.selectColor,
          selected: controller.isSelected(model),
          onTap: () => controller.onItemClick(model),
        ));
  }

  List<Widget> buildItems() {
    final items = <Widget>[];

    /// 模式
    items.addAll(AppTheme.themes
        .where((e) => e.mode != null)
        .map((e) => buildItem(e))
        .toList());

    /// 分割
    items.add(const Divider(height: 8));

    /// 颜色
    items.addAll(AppTheme.themes
        .where((e) => e.color != null)
        .map((e) => buildItem(e))
        .toList());

    return items;
  }
}
