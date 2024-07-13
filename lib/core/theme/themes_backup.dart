import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/core/storage/storage.dart';
import 'package:get/get.dart';

// ThemeData({
// Brightness brightness, //深色还是浅色
// MaterialColor primarySwatch, //主题颜色样本，见下面介绍
// Color primaryColor, //主色，决定导航栏颜色
// Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
// Color cardColor, //卡片颜色
// Color dividerColor, //分割线颜色
// ButtonThemeData buttonTheme, //按钮主题
// Color cursorColor, //输入框光标颜色
// Color dialogBackgroundColor,//对话框背景颜色
// String fontFamily, //文字字体
// TextTheme textTheme,// 字体主题，包括标题、body等文字样式
// IconThemeData iconTheme, // Icon的默认样式
// TargetPlatform platform, //指定平台，应用特定平台控件风格
// ...
// })

enum Theme {
  green,
  yellow,
  red,
  dark,
  light,
}

class AppThemeBackup {
  static const _themeKey = "theme";

  static ThemeData get theme {
    var mode = Storage.read<String>(_themeKey);
    if (mode == Theme.green.name) {
      return _green();
    } else if (mode == Theme.yellow.name) {
      return _yellow();
    } else if (mode == Theme.red.name) {
      return _red();
    } else if (mode == Theme.dark.name) {
      return _dark();
    } else {
      return _yellow();
    }
  }

  static set themeMode(Theme mode) {
    switch (mode) {
      case Theme.green:
        Get.changeTheme(_green());
        break;
      case Theme.yellow:
        Get.changeTheme(_yellow());
        break;
      case Theme.red:
        Get.changeTheme(_red());
        break;
      case Theme.dark:
        Get.changeTheme(_dark());
        break;
      case Theme.light:
        Get.changeTheme(_light());
        break;
    }
    Storage.write(_themeKey, mode.name);
  }

  static ThemeData _green() {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.green,
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
      tabBarTheme: const TabBarTheme(
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelColor: Colors.white),
      iconTheme: const IconThemeData(color: Colors.green),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green))),
      checkboxTheme:
          CheckboxThemeData(fillColor: MaterialStateProperty.all(Colors.green)),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.green),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.green),
    );
  }

  static ThemeData _yellow() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.yellow.shade700, // status bar color
      statusBarBrightness: Brightness.dark, //status bar brigtness
      statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    ));

    return ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.yellow.shade700,
            centerTitle: false,
            actionsIconTheme: const IconThemeData(color: Colors.black),
            iconTheme: const IconThemeData(color: Colors.black),
            titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        scaffoldBackgroundColor: Colors.white,
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: Colors.yellow.shade700),
        primaryColor: Colors.yellow.shade700,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.yellow.shade700,
            unselectedItemColor: Colors.black54),
        tabBarTheme: const TabBarTheme(
            labelStyle: TextStyle(fontWeight: FontWeight.w700),
            labelColor: Colors.black,
            indicatorColor: Colors.black38),
        iconTheme: IconThemeData(color: Colors.yellow.shade700),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 16)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all(Colors.yellow.shade700))),
        checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(Colors.yellow.shade700)),
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Colors.yellow.shade700),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.yellow.shade700),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 16)),
                foregroundColor: MaterialStateProperty.all(Colors.black))));
  }

  static ThemeData _red() {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.red,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.red,
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(selectedItemColor: Colors.red),
      tabBarTheme: const TabBarTheme(
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelColor: Colors.white),
      iconTheme: const IconThemeData(color: Colors.red),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red))),
      checkboxTheme:
          CheckboxThemeData(fillColor: MaterialStateProperty.all(Colors.red)),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.red),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.red),
    );
  }

  static ThemeData _dark() {
    return ThemeData.dark().copyWith(
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Colors.red,
        //   centerTitle: false,
        //   iconTheme: IconThemeData(color: Colors.white),
        //   titleTextStyle: TextStyle(
        //       color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        // ),
        // scaffoldBackgroundColor: Colors.white,
        // primaryColor: Colors.red,
        // bottomNavigationBarTheme:
        //     const BottomNavigationBarThemeData(selectedItemColor: Colors.red),
        // tabBarTheme: const TabBarTheme(
        //     labelStyle: TextStyle(fontWeight: FontWeight.w500),
        //     labelColor: Colors.white),
        // iconTheme: const IconThemeData(color: Colors.red),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all(Colors.red))),
        // checkboxTheme:
        //     CheckboxThemeData(fillColor: MaterialStateProperty.all(Colors.red)),
        // textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.red),
        // floatingActionButtonTheme:
        //     const FloatingActionButtonThemeData(backgroundColor: Colors.red),
        );
  }

  static ThemeData _light() {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(selectedItemColor: Colors.black),
      tabBarTheme: const TabBarTheme(
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelColor: Colors.black),
      iconTheme: const IconThemeData(color: Colors.black),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.black)))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.black)),
              backgroundColor: MaterialStateProperty.all(Colors.white))),
      checkboxTheme:
          CheckboxThemeData(fillColor: MaterialStateProperty.all(Colors.black)),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.black),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.white),
    );
  }
}
