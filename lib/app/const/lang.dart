import 'dart:ui';

import 'package:flutter_wan_android/app/const/keys.dart';
import 'package:flutter_wan_android/core/init/storage.dart';
import 'package:get/get.dart';

class Languages extends Translations {
  static const fallbackLocale = Locale('zh', 'CN');

  static Locale? get locale {
    final key = Storage.read(Keys.languageKey);

    if (key != null) {
      return langMappings[key];
    }
    return Get.deviceLocale;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': zhCN,
        'en_US': enUS,
      };
}

final langMappings = {
  '跟随系统': PlatformDispatcher.instance.locale,
  '中文': const Locale("zh", "CN"),
  'English': const Locale("en", "US"),
};

const zhCN = {
  'home': '首页',
  'languageSetting': '语言设置',
  'label': '玩安卓',
};

const enUS = {
  'home': 'Home',
  'languageSetting': 'Language Setting',
  'label': 'WanAndroid',
};
