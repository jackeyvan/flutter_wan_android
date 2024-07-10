import 'package:get/get.dart';

import 'tab_controller.dart';

abstract class GetTabPage<C extends GetTabController> extends GetView<C> {
  const GetTabPage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   // Get.put(PlatformTabController());
  //
  //   return controller.obx((tabs) => Scaffold(
  //         appBar: PreferredSize(
  //           preferredSize: const Size.fromHeight(48),
  //           child: AppBar(
  //             bottom: controller.buildTabBar(),
  //           ),
  //         ),
  //         body: TabBarView(
  //           controller: controller.tabController,
  //           children: buildPages(tabs),
  //         ),
  //       ));
  // }
}
