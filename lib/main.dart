import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/routes.dart';
import 'app/service/app_service.dart';
import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// run app before init dependencies and some config.
  await AppService().dependencies();

  runApp(const TestApp());
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

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "玩安卓",
      home: Scaffold(
        body: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          margin: EdgeInsets.all(12),
          child: InkWell(
            // radius: 48,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: ListTile(
              title: Text("我是标题呢"),
              subtitle: Text(
                  "我是内容那你信不信啊我是内容那你信不信啊怎么办我是内容那你信不信啊怎么办我是内容那你信不信啊怎么办我是内容那你信不信啊怎么办我是内容那你信不信啊怎么办怎么办"),
            ),
            onTap: () {
              print("-----> 点击了卡片");
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
