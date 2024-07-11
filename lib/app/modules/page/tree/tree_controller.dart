import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/tree_model.dart';
import 'package:flutter_wan_android/app/modules/page/tree/tree_page.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_controller.dart';
import 'package:flutter_wan_android/core/page/tab/tab_controller.dart';
import 'package:get/get.dart';

import 'tree_provider.dart';

class TreeTabController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void onInit() {
    _tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  get tabController => _tabController;
}

class TreeController extends GetRefreshListController<TreeModel> {
  final _provider = TreeProvider();

  final bool fromTree;

  TreeController(this.fromTree);

  @override
  Future<List<TreeModel>> loadData(int page) {
    if (fromTree) {
      return _provider.treeTabs();
    } else {
      return _provider.naviTabs();
    }
  }
}

class TreeDetailTabController extends GetTabController<TreeModel> {
  @override
  Future<List<TreeModel>> loadTabs() {
    var args = Get.arguments;
    if (args is List<TreeModel>) {
      return Future.value(args);
    }
    return Future.value([]);
  }

  @override
  List<Widget> buildPages(List<TreeModel> tabs) {
    return tabs.map((tab) => TreeDetailListPage(tab.id)).toList();
  }

  @override
  TabBar buildTabBar(List<TreeModel> tabs) {
    var data = tabs
        .map((e) => Tab(
              text: e.name,
            ))
        .toList();

    return TabBar(
      labelStyle: const TextStyle(fontSize: 15),
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      tabs: data,
      controller: tabController,
    );
  }
}

class TreeDetailListController extends GetRefreshListController<ArticleModel> {
  final _provider = TreeProvider();

  final int? id;

  TreeDetailListController({required this.id});

  @override
  Future<List<ArticleModel>> loadData(int page) {
    return _provider.treeList(page, id ?? 0).then((e) => e.datas ?? []);
  }
}
