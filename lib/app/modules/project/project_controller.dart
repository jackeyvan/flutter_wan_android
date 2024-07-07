import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/project_tab_model.dart';
import 'project_provider.dart';

class ProjectController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _provider = ProjectProvider();

  final _tabs = <ProjectTabModel>[].obs;

  late TabController _tabController;

  @override
  void onInit() {
    super.onInit();

    _tabController = TabController(vsync: this, length: _tabs.length);

    print("------------> ProjectController ---- onInit");

    _provider.projectTables().then((value) {
      _tabController.index = value.length;
      print("------------> ProjectController ---- ${value.length}");
      _tabs.addAll(value);
      update();
    });
  }

  get tabController => _tabController;

  List<Tab> buildTabs() {
    var tabs = <Tab>[];
    for (var tab in _tabs) {
      tabs.add(Tab(text: tab.name));
    }
    return tabs;
  }

  List<Widget> buildPages() {
    var pages = <Widget>[];
    for (var page in _tabs) {
      pages.add(Text("${page.name}"));
    }
    return pages;
  }
}
