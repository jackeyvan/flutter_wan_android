import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("玩安卓")),
        floatingActionButton:
            FloatingActionButton(onPressed: controller.increat),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: controller.login, child: const Text("登录")),
              ElevatedButton(
                  onPressed: controller.logout, child: const Text("退出登录")),
            ],
          ),
        ));
  }
}
