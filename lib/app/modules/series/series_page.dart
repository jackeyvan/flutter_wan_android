import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'series_controller.dart';

class SeriesPage extends GetView<SeriesController> {
  @override
  Widget build(BuildContext context) {
    return GetX<SeriesController>(
        init: SeriesController(),
        builder: (c) => Scaffold(
                body: Center(
              child: Text(c.data.value),
            )));
  }
}
