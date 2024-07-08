import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/keep_alive_wrapper.dart';
import 'model/project_tab_model.dart';
import 'project_page.dart';
import 'project_tab_controller.dart';

class ProjectTabPage extends GetView<ProjectTabController> {
  const ProjectTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectTabController());

    return controller.obx((tabs) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: AppBar(
              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: buildTabs(tabs),
                controller: controller.tabController,
              ),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: buildPages(tabs),
          ),
        ));
  }

  List<Tab> buildTabs(List<ProjectTabModel>? tabs) =>
      tabs?.map((tab) => Tab(text: tab.name)).toList() ?? [];

  List<Widget> buildPages(List<ProjectTabModel>? tabs) {
    return tabs
            ?.map((tab) => KeepAliveWrapper(child: ProjectPage(id: tab.id)))
            .toList() ??
        [];
  }
}
