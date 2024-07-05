import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/routes.dart';
import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// run app before init dependencies and some config.
  await GlobeConfig.dependencies();

  runApp(const WanApp());
}

class WanApp extends StatelessWidget {
  const WanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "玩安卓",
      initialRoute: Routes.splash,
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      theme: AppTheme.theme,
    );
  }
}
