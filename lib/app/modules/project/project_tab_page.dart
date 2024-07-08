import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/keep_alive_wrapper.dart';
import 'project_page.dart';
import 'project_tab_controller.dart';

class ProjectTabPage extends GetView<ProjectTabController> {
  const ProjectTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectTabController>(
        init: ProjectTabController(),
        builder: (c) => Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: AppBar(
                  bottom: TabBar(
                    tabAlignment: TabAlignment.start,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    tabs: buildTabs(),
                    controller: c.tabController,
                  ),
                ),
              ),
              body: TabBarView(
                controller: c.tabController,
                children: buildPages(),
              ),
            ));
  }

  List<Tab> buildTabs() =>
      controller.tabs.map((tab) => Tab(text: tab.name)).toList();

  List<Widget> buildPages() {
    return controller.tabs
        .map((tab) => KeepAliveWrapper(child: ProjectPage(id: tab.id)))
        .toList();
  }
}
