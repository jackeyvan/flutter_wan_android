import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_controller.dart';
import 'package:flutter_wan_android/core/page/tab/tab_controller.dart';
import 'package:flutter_wan_android/core/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'platform_page.dart';
import 'platform_provider.dart';

class PlatformTabController extends GetTabController<ArticleTabModel> {
  @override
  List<Widget> buildPages() => tabs
      .map((tab) => KeepAliveWrapper(child: PlatformPage(id: tab.id)))
      .toList();

  @override
  TabBar buildTabBar() => TabBar(
        labelStyle: const TextStyle(fontSize: 15),
        tabAlignment: TabAlignment.start,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        tabs: tabs.map((tab) => Tab(text: tab.name)).toList(),
        controller: tabController,
      );

  @override
  Future<List<ArticleTabModel>> loadTabs() =>
      Get.find<PlatformProvider>().platformTab();
}

class PlatformController extends GetRefreshListController<ArticleModel> {
  final int? id;

  PlatformController({this.id});

  @override
  Future<List<ArticleModel>> loadData(int page) {
    return Get.find<PlatformProvider>()
        .platformList(id ?? 0, page)
        .then((e) => e.datas ?? []);
  }
}
