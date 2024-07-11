import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_controller.dart';
import 'package:get/get.dart';

import 'project_provider.dart';

class ProjectTabController extends GetxController
    with GetTickerProviderStateMixin, StateMixin<List<ArticleTabModel>> {
  final _provider = ProjectProvider();

  late TabController _tabController;

  @override
  void onReady() {
    _tabController = TabController(vsync: this, length: 0);

    _provider.projectTabs().then((value) {
      _tabController = TabController(vsync: this, length: value.length);
      change(value, status: RxStatus.success());
    }).onError((err, stack) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  // get update => value??[];

  get tabController => _tabController;

  List<ArticleTabModel> get tabs => value ?? [];
}

class ProjectController extends GetRefreshListController<ArticleModel> {
  final _provider = ProjectProvider();

  final int? id;

  ProjectController({this.id});

  @override
  Future<List<ArticleModel>> loadData(int page) =>
      _provider.projectList(id ?? 0, page).then((value) => value.datas ?? []);
}
