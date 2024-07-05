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
            child: Obx(
          () => Column(
            children: [Text(controller.data), Text("${controller.count}")],
          ),
        )));
  }
}
