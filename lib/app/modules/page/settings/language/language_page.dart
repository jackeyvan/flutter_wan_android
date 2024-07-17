import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/base/appbar_page.dart';
import 'package:get/get.dart';

import 'language_controller.dart';

class LanguagePage extends AppbarPage<LanguageController> {
  const LanguagePage({super.key});

  @override
  Widget buildBodyPage() {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: controller.languages.length,
        itemBuilder: (context, index) => Obx(() => ListTile(
            selectedTileColor: controller.selectColor,
            selected: controller.isSelected(index),
            onTap: () => controller.onItemClick(index),
            title: Text(controller.languages[index]))));
  }
}
