import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'project_controller.dart';

class ProjectPage extends GetView<ProjectController> {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(
        init: ProjectController(),
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
    return controller.tabs.map((tab) => ProjectSubPage(id: tab.id)).toList();
  }
}

class ProjectSubPage extends GetView<ProjectController> {
  final int? id;

  ProjectSubPage({this.id});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("${id}"));
  }
}
