import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/base/appbar_page.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/tree_model.dart';
import 'package:flutter_wan_android/app/modules/widget/article_item_widget.dart';
import 'package:flutter_wan_android/app/modules/widget/tree_wrap_widget.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_page.dart';
import 'package:get/get.dart';

import 'tree_controller.dart';

/// 体系首页带有Tab的页面，加载Tab并且填充页面
class TreeTabPage extends AppbarPage<TreeTabController> {
  const TreeTabPage({super.key});
}

/// 体系首页页面，填充具体Tab对应的页面
class TreeListPage extends GetRefreshPage<TreeController> {
  final String tab;
  final bool fromTree;

  TreeListPage(this.tab, {super.key})
      : fromTree = tab == Get.find<TreeTabController>().tabData[0];

  @override
  String? get tag => tab;

  @override
  void dependencies() {
    Get.lazyPut(() => TreeController(fromTree), tag: tab);
  }

  @override
  Widget buildPage(BuildContext context) => buildObxRefreshListPage<TreeModel>(
        padding: const EdgeInsets.all(12),
        itemBuilder: (item, index) => TreeWrap(
          title: item.name,
          items: item.items,
          onItemTrap: (data, index) {
            /// 体系跳转
            if (fromTree) {
              var tabs = item.items ?? [];
              if (tabs.isNotEmpty) {
                item.index = index;
                Routes.toNamed(Routes.treeDetail, args: item);
              }
            } else {
              /// 导航跳转到WebView
              if (data.link != null) {
                Routes.toNamed(Routes.articleDetail,
                    args: ArticleModel(title: data.name, link: data.link));
              }
            }
          },
        ),
      );
}

/// 体系详情页，一级Tab页面
class TreeDetailTabPage extends AppbarPage<TreeDetailTabController> {
  const TreeDetailTabPage({super.key});
}

/// 体系详情页，具体Tab对应的页面
class TreeDetailListPage extends GetRefreshPage<TreeDetailListController> {
  final int? id;

  const TreeDetailListPage(this.id, {super.key});

  @override
  String? get tag => id?.toString();

  @override
  void dependencies() {
    Get.lazyPut(() => TreeDetailListController(id: id), tag: id?.toString());
  }

  @override
  Widget buildPage(BuildContext context) =>
      buildObxRefreshListPage<ArticleModel>(
        padding: const EdgeInsets.all(8),
        separatorBuilder: (item, index) => const SizedBox(height: 3),
        itemBuilder: (item, index) => ArticleItemWidget(item),
      );
}
