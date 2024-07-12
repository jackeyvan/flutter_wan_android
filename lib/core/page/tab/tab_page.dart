import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tab_controller.dart';

class GetTabPage<C extends GetTabController> extends GetView<C> {
  const GetTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    dependencies();
    return controller.obx((_) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: AppBar(
              bottom: controller.buildTabBar(),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: controller.buildPages(),
          ),
        ));
  }

  /// 如果不走Route注入的话，子类可以用这个方法去绑定Controller
  void dependencies() {}
}
