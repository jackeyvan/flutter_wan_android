import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    print("--------------> HomePage build");
    return GetBuilder(
        init: HomeController(),
        builder: (c) => Scaffold(
                body: Center(
              child: Text(controller.testdata.value),
            )));
  }
}
