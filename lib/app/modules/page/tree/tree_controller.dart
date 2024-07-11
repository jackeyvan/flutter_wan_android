import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/tree_model.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_controller.dart';
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
