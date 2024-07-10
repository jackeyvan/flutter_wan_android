import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tree_controller.dart';

class TreeHomePage extends GetView<TreeController> {
  @override
  Widget build(BuildContext context) {
    return GetX<TreeController>(
        init: TreeController(),
        builder: (c) => Scaffold(
                body: Center(
              child: Text(c.data.value),
            )));
  }
}
