import 'package:flutter/material.dart';

/// 资源管理静态类

class LocalStyles {
  // static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
}

class LocalIcons {
  // static const String FONT_FAMILY = 'wxcIconFont';
}

///文本样式
class Strings {
  static const String github =
      "https://github.com/CarGuo/gsy_github_app_flutter";

  static const String label = "label";
  static const String home = "home";
  static const String project = "project";
  static const String platform = "platform";

  static const String languageSetting = "languageSetting";

  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static const minText = TextStyle(
    // color: GSYColors.subLightTextColor,
    fontSize: minTextSize,
  );

  /// 转义一下特殊字符
  ///
  /// "	双引号（英文）	&quot;
  /// ‘	左单引号	&lsquo;
  /// ’	右单引号	&rsquo;
  /// ×	乘号	&times;
  /// ÷	除号	&divide;
  /// >	大于号	&gt;
  /// <	小于号	&lt;
  /// &	“与”符号	&amp;
  /// —	长破折号	&mdash;
  /// |	竖线	&#124;
  ///
  static String escape(String value) {
    return value
        .replaceAll(RegExp(r'<[^>]*>|&nbsp;'), '')
        .replaceAll(RegExp(r'<[^>]*>|&quot;'), '""')
        .replaceAll(RegExp(r'<[^>]*>|&amp;'), '&')
        .replaceAll(RegExp(r'<[^>]*>|&times;'), '×')
        .replaceAll(RegExp(r'<[^>]*>|&divide;'), '÷')
        .replaceAll(RegExp(r'<[^>]*>|&lsquo;'), '"')
        .replaceAll(RegExp(r'<[^>]*>|&rsquo;'), '"')
        .replaceAll(RegExp(r'<[^>]*>|&gt;'), '>')
        .replaceAll(RegExp(r'<[^>]*>|&lt;'), '<')
        .replaceAll(RegExp(r'<[^>]*>|&#124;'), '|')
        .replaceAll(RegExp(r'<[^>]*>|&mdash;'), '—');
  }
}

class FontSize {
  // static const lagerTextSize = 30.0;
}
