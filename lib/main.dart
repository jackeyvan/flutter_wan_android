import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/routes/binding.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/theme/themes.dart';
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
      title: "玩安卓",
      initialRoute: Routes.root,
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      // theme: AppTheme.theme,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    );
  }
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "玩安卓",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("玩安卓"),
        ),
        body: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          margin: const EdgeInsets.all(12),
          child: InkWell(
            // radius: 48,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: const ListTile(
              title: Text("我是标题呢"),
              subtitle: Text(
                  "我是内容那你信不信啊我是内容那你信不信啊怎么办我是内容那你信不信啊怎么办我是内容那你信不信啊怎么办我是内容那你信不信啊怎么办我是内容那你信不信啊怎么办怎么办"),
            ),
            onTap: () {
              // print("-----> 点击了卡片");
            },
          ),
        ),
      ),
    );
  }
}

//
// body: InkWell(
// child: Card(
// margin: EdgeInsets.all(12),
// child: ListTile(
// title: Text("我是标题呢"),
// subtitle: Text("我是内容那你信不信啊怎么办"),
// )),
// onTap: () {
// print("-----> 点击了卡片");
// }),
