import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/base/tab_controller.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';
import 'package:flutter_wan_android/core/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'project_page.dart';
import 'project_provider.dart';

class ProjectTabController extends GetTabController<ArticleTabModel> {
  @override
  List<Widget> buildPages() => tabData
      .map((tab) => KeepAliveWrapper(child: ProjectPage(id: tab.id)))
      .toList();

  @override
  Future<List<ArticleTabModel>> loadTabs() =>
      Get.find<ProjectProvider>().projectTabs();

  @override
  List<Widget> buildTabs() =>
      tabData.map((tab) => Tab(text: tab.name)).toList();

  @override
  String get title => "项目";

  @override
  bool get isShowDrawer => true;
}

class ProjectController extends GetRefreshListController<ArticleModel> {
  final int? id;

  ProjectController({this.id}) : super(initPage: 1);

  @override
  Future<List<ArticleModel>> loadListData(int page, bool isRefresh) =>
      Get.find<ProjectProvider>().projectList(id ?? 0, page).then((value) =>
          value.datas?.map((e) {
            /// 重置一下文章数据
            e.tags = null;
            e.superChapterName = null;
            e.chapterName = null;
            return e;
          }).toList() ??
          []);
}
