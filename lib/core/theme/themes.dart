import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/storage/storage.dart';
import 'package:get/get.dart';

import 'theme_model.dart';

class AppTheme {
  static const _themeKey = "theme";
  static const _themeModeKey = "themeMode";

  static ThemeData get theme {
    final themeName = readTheme();
    final model = themes.firstWhere((element) => element.name == themeName,
        orElse: () => themes.first);

    model.mode = readThemeMode();

    return _wrapChangeTheme(model);
  }

  static final light = generateTheme(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.green,
  );

  static final dark = generateTheme(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.green,
  );

  /// 可以根据不同的颜色，定制不同的主题
  static ThemeData generateTheme({
    required Brightness brightness,
    required Color colorSchemeSeed,
  }) {
    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorSchemeSeed: colorSchemeSeed,
    );
  }

  static changeTheme(ThemeModel model) {
    _wrapChangeTheme(model);

    /// 修改主题之后保存对应主颜色名字
    Storage.write(_themeKey, model.name);

    if (model.mode != null) {
      Storage.write(_themeModeKey, model.mode!.name);
    }
  }

  static ThemeData _wrapChangeTheme(ThemeModel model) {
    print("------> theme : ${model.name} -- mode ${model.mode?.name}");

    final mode = model.mode;
    final color = model.color;

    if (mode != null) {
      Get.changeTheme(dark);
      Get.changeTheme(light);
      Get.changeThemeMode(mode);
    } else if (color != null) {
      final themeData = generateTheme(
        brightness: Get.theme.brightness,
        colorSchemeSeed: color,
      );
      Get.changeTheme(themeData);
      Get.changeThemeMode(ThemeMode.light);

      ///  TODO 更换颜色只有白色模式才会生效
      // if (mode != null && mode == ThemeMode.dark) {
      //   Get.changeThemeMode(ThemeMode.light);
      // }
      return themeData;
    }
    return light;
  }

  static String readTheme() {
    return Storage.read(_themeKey) ?? "System";
  }

  static ThemeMode readThemeMode() {
    final mode = Storage.read(_themeModeKey);

    if (mode != null) {
      return ThemeMode.values.firstWhere((element) => element.name == mode,
          orElse: () => ThemeMode.values.first);
    }

    return ThemeMode.system;
  }

  static final themes = [
    ThemeModel(
      name: 'System',
      mode: ThemeMode.system,
      icon: GetPlatform.isMobile ? Icons.phone_android : Icons.computer,
    ),
    ThemeModel(
      name: 'Light',
      mode: ThemeMode.light,
      icon: Icons.light_mode,
    ),
    ThemeModel(
      name: 'Dark',
      mode: ThemeMode.dark,
      icon: Icons.dark_mode,
    ),
    ThemeModel(
      name: 'Blue',
      color: Colors.blue,
    ),
    ThemeModel(
      name: 'Red',
      color: Colors.red,
    ),
    ThemeModel(
      name: 'Pink',
      color: Colors.pink,
    ),
    ThemeModel(
      name: 'Purple',
      color: Colors.purple,
    ),
    ThemeModel(
      name: 'DeepPurple',
      color: Colors.deepPurple,
    ),
    ThemeModel(
      name: 'Indigo',
      color: Colors.indigo,
    ),
    ThemeModel(
      name: 'LightBlue',
      color: Colors.lightBlue,
    ),
    ThemeModel(
      name: 'Cyan',
      color: Colors.cyan,
    ),
    ThemeModel(
      name: 'Teal',
      color: Colors.teal,
    ),
    ThemeModel(
      name: 'LightGreen',
      color: Colors.lightGreen,
    ),
    ThemeModel(
      name: 'Lime',
      color: Colors.lime,
    ),
    ThemeModel(
      name: 'Yellow',
      color: Colors.yellow,
    ),
    ThemeModel(
      name: 'Amber',
      color: Colors.amber,
    ),
    ThemeModel(
      name: 'Orange',
      color: Colors.orange,
    ),
    ThemeModel(
      name: 'DeepOrange',
      color: Colors.deepOrange,
    ),
    ThemeModel(
      name: 'Brown',
      color: Colors.brown,
    ),
    ThemeModel(
      name: 'Grey',
      color: Colors.grey,
    ),
    ThemeModel(
      name: 'BlueGrey',
      color: Colors.blueGrey,
    ),
  ];

// static ThemeData _yellow() {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.yellow.shade700, // status bar color
//     statusBarBrightness: Brightness.dark, //status bar brigtness
//     statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
//   ));
//
//   return ThemeData.light().copyWith(
//       appBarTheme: AppBarTheme(
//           backgroundColor: Colors.yellow.shade700,
//           centerTitle: false,
//           actionsIconTheme: const IconThemeData(color: Colors.black),
//           iconTheme: const IconThemeData(color: Colors.black),
//           titleTextStyle: const TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w500)),
//       scaffoldBackgroundColor: Colors.white,
//       progressIndicatorTheme:
//       ProgressIndicatorThemeData(color: Colors.yellow.shade700),
//       primaryColor: Colors.yellow.shade700,
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           selectedItemColor: Colors.yellow.shade700,
//           unselectedItemColor: Colors.black54),
//       tabBarTheme: const TabBarTheme(
//           labelStyle: TextStyle(fontWeight: FontWeight.w700),
//           labelColor: Colors.black,
//           indicatorColor: Colors.black38),
//       iconTheme: IconThemeData(color: Colors.yellow.shade700),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ButtonStyle(
//               textStyle:
//               MaterialStateProperty.all(const TextStyle(fontSize: 16)),
//               foregroundColor: MaterialStateProperty.all(Colors.black),
//               backgroundColor:
//               MaterialStateProperty.all(Colors.yellow.shade700))),
//       checkboxTheme: CheckboxThemeData(
//           fillColor: MaterialStateProperty.all(Colors.yellow.shade700)),
//       textSelectionTheme:
//       TextSelectionThemeData(cursorColor: Colors.yellow.shade700),
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//           backgroundColor: Colors.yellow.shade700),
//       textButtonTheme: TextButtonThemeData(
//           style: ButtonStyle(
//               textStyle:
//               MaterialStateProperty.all(const TextStyle(fontSize: 16)),
//               foregroundColor: MaterialStateProperty.all(Colors.black))));
// }
}
