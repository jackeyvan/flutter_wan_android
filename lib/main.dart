import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/routes.dart';
import 'app/service/app_service.dart';
import 'core/core.dart';

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
      title: "玩安卓",
      initialRoute: Routes.root,
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      theme: AppTheme.theme,
    );
  }
}
