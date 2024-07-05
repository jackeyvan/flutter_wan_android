import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("玩安卓")),
      body: Column(
        children: [
          Text(controller.result),
        ],
      ),
    );
  }
}
