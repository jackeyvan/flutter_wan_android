import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/widget/theme_item_widget.dart';
import 'package:flutter_wan_android/core/theme/themes_backup.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  static final themeModes = AppThemeBackup.themeModes;
  static final themeColors = AppThemeBackup.themeColors;

  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: const Text("测试页面"),
      ),
      body: ListView(
        children: buildItems(),
      ),
    );
  }

  List<Widget> buildItems() {
    final items = <Widget>[];

    final item = themeModes
        .map((e) => ListItem(
              title: e.name,
              leading: Icon(e.icon),
              onTap: () {
                AppThemeBackup.changeThemeMode(e.mode!);
              },
            ))
        .toList();

    items.addAll(item);

    items.add(const Divider(height: 12));

    final colors = themeColors
        .map((e) => ListItem(
              title: e.name,
              leading: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: e.color,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onTap: () {
                final themeData = AppThemeBackup.generateTheme(
                  brightness: Get.theme.brightness,
                  colorSchemeSeed: e.color!,
                );

                AppThemeBackup.changeTheme(themeData);
              },
            ))
        .toList();

    items.addAll(colors);

    return items;
  }
}
