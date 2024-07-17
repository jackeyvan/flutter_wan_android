import 'dart:ui';

import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'home': '首页',
          'languageSetting': '语言设置',
        },
        'en_US': {
          'home': 'Home',
          'languageSetting': 'Language Setting',
        }
      };

  Map<String, dynamic> get mappings => {
        '跟随系统': PlatformDispatcher.instance.locale,
        '中文': const Locale("zh", "CN"),
        'English': const Locale("en", "US"),
      };
}
