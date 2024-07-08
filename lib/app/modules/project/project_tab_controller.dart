import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/project_tab_model.dart';
import 'provider/project_provider.dart';

class ProjectTabController extends GetxController
    with GetTickerProviderStateMixin {
  final _provider = ProjectProvider();

  final _tabs = <ProjectTabModel>[].obs;

  final data = "测试".obs;

  late TabController _tabController;

  @override
  void onInit() {
    super.onInit();
    _tabController = TabController(vsync: this, length: _tabs.length);

    _provider.projectTables().then((value) {
      _tabController = TabController(vsync: this, length: value.length);

      _tabs.addAll(value);
      update();
    });
  }

  get tabController => _tabController;

  List<ProjectTabModel> get tabs => _tabs;
}
