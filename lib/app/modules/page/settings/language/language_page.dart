import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/base/appbar_page.dart';
import 'package:get/get.dart';

import 'language_controller.dart';

class LanguagePage extends AppbarPage<LanguageController> {
  const LanguagePage({super.key});

  @override
  Widget buildBodyPage() {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: controller.languages.map((e) => buildItem(e)).toList(),
    );
  }

  Widget buildItem(String item) {
    return Obx(() => ListTile(
        selectedTileColor: controller.selectColor,
        selected: controller.isSelected(item),
        onTap: () => controller.onItemClick(item),
        title: Text(item)));
  }
}
