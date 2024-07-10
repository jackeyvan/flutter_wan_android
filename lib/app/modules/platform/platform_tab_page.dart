import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/platform/platform_page.dart';
import 'package:get/get.dart';

import '../../../core/widgets/keep_alive_wrapper.dart';
import 'platform_tab_controller.dart';

class PlatformTabPage extends GetView<PlatformTabController> {
  const PlatformTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlatformTabController());

    return controller.obx((tabs) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: AppBar(
              bottom: TabBar(
                labelStyle: TextStyle(fontSize: 15),
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: buildTabs(),
                controller: controller.tabController,
              ),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: buildPages(),
          ),
        ));
  }

  List<Tab> buildTabs() =>
      controller.tabs.map((tab) => Tab(text: tab.name)).toList();

  List<Widget> buildPages() => controller.tabs
      .map((tab) => KeepAliveWrapper(child: PlatformPage(id: tab.id)))
      .toList();
}
