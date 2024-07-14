import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/widget/theme_item_widget.dart';
import 'package:flutter_wan_android/core/theme/themes.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
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

    final item = AppTheme.themes
        .where((e) => e.mode != null)
        .map((e) => ListItem(
              title: e.name,
              leading: Icon(e.icon),
              onTap: () {
                AppTheme.changeThemeMode(e.mode!);
              },
            ))
        .toList();

    items.addAll(item);

    items.add(const Divider(height: 12));

    final colors = AppTheme.themes
        .where((e) => e.color != null)
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
                final themeData = AppTheme.generateTheme(
                  brightness: Get.theme.brightness,
                  colorSchemeSeed: e.color!,
                );

                AppTheme.changeTheme(theme: themeData);
              },
            ))
        .toList();

    items.addAll(colors);

    return items;
  }
}
