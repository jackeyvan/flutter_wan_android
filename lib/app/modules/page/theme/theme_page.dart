import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/widget/theme_item_widget.dart';
import 'package:flutter_wan_android/core/page/base/base_page.dart';
import 'package:flutter_wan_android/core/theme/theme_model.dart';
import 'package:flutter_wan_android/core/theme/themes.dart';

import 'theme_controller.dart';

class ThemePage extends BasePage<ThemeController> {
  const ThemePage({super.key});

  @override
  Widget buildPage() {
    return Scaffold(
        appBar: AppBar(
          title: const Text("主题选择"),
        ),
        body: ListView(
          children: buildItems(),
        ));
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
      selectBgColor: controller.selectColor,
      selected: controller.isSelected(model),
      onTap: () => controller.onItemClick(model),
    );
  }

  List<Widget> buildItems() {
    final items = <Widget>[];

    /// 模式
    items.addAll(AppTheme.themes
        .where((e) => e.mode != null)
        .map((e) => buildItem(e))
        .toList());

    /// 分割
    items.add(const Divider(height: 12));

    /// 颜色
    items.addAll(AppTheme.themes
        .where((e) => e.color != null)
        .map((e) => buildItem(e))
        .toList());

    return items;
  }
}
