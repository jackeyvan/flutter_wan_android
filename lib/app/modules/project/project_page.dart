import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'project_controller.dart';

class ProjectPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(
        init: ProjectController(),
        builder: (c) => Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(56),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    tabs: c.buildTabs(),
                    controller: c.tabController,
                  ),
                ),
              ),
              body: TabBarView(
                controller: c.tabController,
                children: c.buildPages(),
              ),
            ));
  }
}
