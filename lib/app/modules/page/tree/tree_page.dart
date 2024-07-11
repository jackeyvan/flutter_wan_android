import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/tree_model.dart';
import 'package:flutter_wan_android/app/modules/widget/tree_wrap_widget.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_page.dart';
import 'package:flutter_wan_android/core/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'tree_controller.dart';

class TreeHomePage extends GetView<TreeTabController> {
  const TreeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TreeTabController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AppBar(
          bottom: TabBar(
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize.label,
            tabAlignment: TabAlignment.center,
            tabs: buildTabs(),
            controller: controller.tabController,
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: buildPages(),
      ),
    );
  }

  buildTabs() => [const Tab(text: "体系"), const Tab(text: "导航")];

  buildPages() => [
        const KeepAliveWrapper(child: TreePage(true)),
        const KeepAliveWrapper(child: TreePage(false))
      ];
}

class TreePage extends GetRefreshListPage<TreeController> {
  final bool fromTree;

  const TreePage(this.fromTree, {super.key});

  @override
  String? get tag => fromTree.toString();

  @override
  Widget build(BuildContext context) {
    Get.put(TreeController(fromTree), tag: fromTree.toString());

    return buildObx(
      builder: () => buildRefreshListView<TreeModel>(
        padding: const EdgeInsets.only(top: 12),
        itemBuilder: (item, index) {
          return TreeWrap(
            title: item.name,
            items: item.items,
            onItemTrap: (data, index) {
              /// 体系跳转
              if (fromTree) {
              } else {
                /// 导航跳转到WebView
                if (data.link != null) {
                  Routes.to(Routes.articleDetail,
                      args: ArticleModel(title: data.name, link: data.link));
                }
              }
            },
          );
        },
      ),
    );
  }
}
