import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'platform_controller.dart';

class PlatformPage extends GetView<PlatformController> {

  @override
  Widget build(BuildContext context) {
    print("--------------> PlatformPage build");

    return GetX<PlatformController>(
        init: PlatformController(),
        builder: (c) => Scaffold(
            body: Center(
              child: Text(c.data.value),
            )));

  }
}
