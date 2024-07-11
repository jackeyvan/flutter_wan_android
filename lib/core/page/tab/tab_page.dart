import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tab_controller.dart';

class GetTabPage<C extends GetTabController> extends GetView<C> {
  const GetTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GetTabController());

    return controller.obx((tabs) => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(controller.tabHeight()),
            child: AppBar(
              bottom: controller.buildTabs(tabs),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: buildPages(tabs),
          ),
        ));
  }
}
