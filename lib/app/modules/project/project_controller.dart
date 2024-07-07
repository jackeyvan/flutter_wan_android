import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/project_tab_model.dart';
import 'project_provider.dart';

class ProjectController extends GetxController
    with GetTickerProviderStateMixin {
  final _provider = ProjectProvider();

  final _tabs = <ProjectTabModel>[].obs;

  late TabController _tabController;

  @override
  void onInit() {
    super.onInit();
    _tabController = TabController(vsync: this, length: 0);

    _provider.projectTables().then((value) {
      _tabController = TabController(vsync: this, length: value.length);

      _tabs.addAll(value);
      update();
    });
  }

  get tabController => _tabController;

  List<ProjectTabModel> get tabs => _tabs;
}
