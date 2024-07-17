import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/const/lang.dart';
import 'package:flutter_wan_android/app/routes/binding.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/init/themes.dart';
import 'package:get/get.dart';

import 'app/service/app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// run app before init dependencies and some config.
  await AppService().dependencies();

  runApp(const WanApp());
}

class WanApp extends StatelessWidget {
  const WanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.root,
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      translations: Languages(),
      locale: Languages.locale,
      fallbackLocale: Languages.fallbackLocale,
    );
  }
}
