import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/const/keys.dart';
import 'package:flutter_wan_android/app/const/languages.dart';
import 'package:flutter_wan_android/app/const/styles.dart';
import 'package:flutter_wan_android/app/modules/base/appbar_controller.dart';
import 'package:flutter_wan_android/core/init/storage.dart';
import 'package:flutter_wan_android/core/init/themes.dart';
import 'package:get/get.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController());
  }
}

class LanguageController extends AppbarController {
  List<String> languages = [];
  final language = "".obs;

  final obj = Languages();

  @override
  void onInit() {
    languages = obj.mappings.keys.toList();

    language.value = Storage.read(Keys.languageKey) ?? languages[0];

    super.onInit();
  }

  @override
  String? get title => Strings.languageSetting;

  void onItemClick(int index) {
    language.value = languages[index];
    final locale = obj.mappings.values.toList()[index];
    Get.updateLocale(locale);

    Storage.write(Keys.languageKey, language.value);
  }

  bool isSelected(int index) {
    return language.value == languages[index];
  }

  Color get selectColor {
    return AppTheme.isDarkMode() ? Colors.white12 : Colors.black12;
  }
}
