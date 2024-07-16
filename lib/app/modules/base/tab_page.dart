import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/page/base/base_page.dart';

import 'tab_controller.dart';

class GetTabPage<C extends GetTabController> extends BasePage<C> {
  const GetTabPage({super.key});

  @override
  Widget buildPage(BuildContext context) => buildObx(
      builder: () => NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  leading: buildAppBarLeading(),
                  title: Text(controller.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                  centerTitle: false,
                  bottom: buildTabBar(),
                  snap: true,
                  pinned: true,
                  floating: true,
                ),
              ];
            },
            body: buildTabView(),
          ));

  Widget? buildAppBarLeading() =>
      controller.isShowDrawer ? const DrawerButton() : null;

  /// 子类也可以自己去定义TabBar
  PreferredSizeWidget buildTabBar() => TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        tabs: controller.buildTabs(),
        controller: controller.tabController,
      );

  buildTabView() => TabBarView(
        controller: controller.tabController,
        children: controller.buildPages(),
      );
}
