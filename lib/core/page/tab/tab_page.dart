import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/widget/tabbar_widget.dart';
import 'package:flutter_wan_android/core/page/base/base_page.dart';

import 'tab_controller.dart';

class GetTabPage<C extends GetTabController> extends BasePage<C> {
  const GetTabPage({super.key});

  @override
  Widget buildPage() => Scaffold(
        appBar: buildTabBar(),
        body: buildTabView(),
      );

  /// 子类也可以自己去定义TabBar
  PreferredSizeWidget buildTabBar() => FixTabBar(
        tabs: controller.buildTabs(),
        controller: controller.tabController,
        title: controller.title,
      );

  buildTabView() => TabBarView(
        controller: controller.tabController,
        children: controller.buildPages(),
      );
}
