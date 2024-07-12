import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';
import 'package:flutter_wan_android/core/page/tab/tab_controller.dart';
import 'package:flutter_wan_android/core/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'platform_page.dart';
import 'platform_provider.dart';

class PlatformTabController extends GetTabController<ArticleTabModel> {
  @override
  List<Widget> buildPages() => tabData
      .map((tab) => KeepAliveWrapper(child: PlatformPage(id: tab.id)))
      .toList();

  @override
  Future<List<ArticleTabModel>> loadTabs() =>
      Get.find<PlatformProvider>().platformTab();

  @override
  List<Widget> buildTabs() =>
      tabData.map((tab) => Tab(text: tab.name)).toList();
}

class PlatformController extends GetRefreshListController<ArticleModel> {
  final int? id;

  /// 项目的列表页从1开始，TODO 修改父类的属性失败
  PlatformController({this.id}) : super(initPage: 3);

  @override
  Future<List<ArticleModel>> loadData(int page, bool isRefresh) {
    return Get.find<PlatformProvider>()
        .platformList(id ?? 0, page)
        .then((e) => e.datas ?? []);
  }
}
