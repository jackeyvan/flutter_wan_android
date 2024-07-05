import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/core.dart';
import 'env/build_env.dart';
import 'routes/routes.dart';

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
      enableLog: Get.find<BuildEnv>().enableLog(),
      title: "玩安卓",
      initialRoute: Routes.splash,
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      theme: AppTheme.theme,
    );
  }
}
