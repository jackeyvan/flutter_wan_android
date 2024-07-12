import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/tree_model.dart';
import 'package:flutter_wan_android/app/modules/widget/tree_wrap_widget.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_page.dart';
import 'package:flutter_wan_android/core/page/tab/tab_page.dart';
import 'package:get/get.dart';

import 'tree_controller.dart';
import 'tree_provider.dart';

/// 体系首页带有Tab的页面，加载Tab并且填充页面
class TreeTabPage extends GetTabPage<TreeTabController> {
  const TreeTabPage({super.key});

  @override
  void dependencies() {
    Get.lazyPut(() => TreeProvider());
    Get.lazyPut(() => TreeTabController());
  }
}

/// 体系首页页面，填充具体Tab对应的页面
class TreePage extends GetRefreshListPage<TreeController> {
  final String tab;
  final bool fromTree;

  TreePage(this.tab, {super.key})
      : fromTree = tab == Get.find<TreeTabController>().tabs[0];

  @override
  String? get tag => tab;

  @override
  void dependencies() {
    Get.lazyPut(() => TreeController(fromTree), tag: tab);
  }

  @override
  Widget buildRefresh() => buildRefreshListView<TreeModel>(
        padding: const EdgeInsets.only(top: 12),
        itemBuilder: (item, index) {
          return TreeWrap(
            title: item.name,
            items: item.items,
            onItemTrap: (data, index) {
              /// 体系跳转
              if (fromTree) {
                var tabs = item.items ?? [];
                if (tabs.isNotEmpty) {
                  Routes.to(Routes.treeDetail, args: tabs);
                }
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
      );
}

/// 体系详情页，一级Tab页面
class TreeDetailTabPage extends GetTabPage<TreeDetailTabController> {
  const TreeDetailTabPage({super.key});
}

/// 体系详情页，具体Tab对应的页面
class TreeDetailListPage extends GetRefreshListPage<TreeDetailListController> {
  final int? id;

  const TreeDetailListPage(this.id, {super.key});

  @override
  String? get tag => id?.toString();

  @override
  void dependencies() {
    Get.lazyPut(() => TreeDetailListController(id: id), tag: id?.toString());
  }

  @override
  Widget buildRefresh() => buildRefreshListView<ArticleModel>(
        padding: const EdgeInsets.only(top: 6),
        itemBuilder: (item, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(6, 0, 6, 6),
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: ListTile(
                    title: Text(
                      "${item.title}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "${item.desc}",
                          maxLines: 5,
                        ))),
                onTap: () => Routes.to(Routes.articleDetail, args: item),
              ),
            ),
          );
        },
      );
}
