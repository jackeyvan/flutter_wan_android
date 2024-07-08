import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/project_tab_model.dart';
import 'provider/project_provider.dart';

class ProjectTabController extends GetxController
    with GetTickerProviderStateMixin, StateMixin<List<ProjectTabModel>> {
  final _provider = ProjectProvider();

  late TabController _tabController;

  @override
  void onInit() {
    super.onInit();
    _tabController = TabController(vsync: this, length: 0);

    _provider.projectTables().then((value) {
      _tabController = TabController(vsync: this, length: value.length);

      this.value?.addAll(value);

      change(value, status: RxStatus.success());
    });
  }

  // get update => value??[];

  get tabController => _tabController;

  List<ProjectTabModel> get tabs => value ?? [];
}
