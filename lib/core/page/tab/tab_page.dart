import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tab_controller.dart';

abstract class GetTabPage<C extends GetTabController> extends GetView<C> {
  const GetTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    initController();
    return controller.obx((_) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: AppBar(
              bottom: controller.buildInnerTabBar(),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: controller.buildInnerPages(),
          ),
        ));
  }

  initController();
}
