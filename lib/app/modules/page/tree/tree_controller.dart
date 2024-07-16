import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/base/tab_controller.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/tree_model.dart';
import 'package:flutter_wan_android/app/modules/page/tree/tree_page.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';
import 'package:get/get.dart';

import 'tree_provider.dart';

class TreeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TreeDetailTabController());
  }
}

class TreeTabController extends GetTabController<String> {
  @override
  List<Widget> buildPages() {
    return tabData.map((e) => keepWidgetAlive(TreeListPage(e))).toList();
  }

  @override
  Future<List<String>> loadTabs() => Future.value(["体系", "导航"]);

  @override
  List<Widget> buildTabs() => tabData.map((e) => Tab(text: e)).toList();

  @override
  String get title => "体系";

  @override
  bool get isShowDrawer => true;
}

class TreeController extends GetRefreshListController<TreeModel> {
  final bool fromTree;

  TreeController(this.fromTree);

  @override
  Future<List<TreeModel>> loadListData(int page, bool isRefresh) {
    final provider = Get.find<TreeProvider>();
    if (fromTree) {
      return provider.treeTabs();
    } else {
      return provider.naviTabs();
    }
  }
}

class TreeDetailTabController extends GetTabController<TreeModel> {
  var index = 0;

  @override
  void showSuccessPage() {
    super.showSuccessPage();

    tabController.animateTo(index);
  }

  @override
  Future<List<TreeModel>> loadTabs() {
    var args = Get.arguments;
    if (args is TreeModel) {
      title = args.name;
      index = args.index;
      return Future.value(args.items);
    }
    return Future.value([]);
  }

  @override
  List<Widget> buildPages() {
    return tabData
        .map((tab) => keepWidgetAlive(TreeDetailListPage(tab.id)))
        .toList();
  }

  @override
  List<Widget> buildTabs() => tabData.map((e) => Tab(text: e.name)).toList();
}

class TreeDetailListController extends GetRefreshListController<ArticleModel> {
  final int? id;

  TreeDetailListController({required this.id});

  @override
  Future<List<ArticleModel>> loadListData(int page, bool isRefresh) {
    return Get.find<TreeProvider>()
        .treeList(page, id ?? 0)
        .then((e) => e.datas ?? []);
  }
}
