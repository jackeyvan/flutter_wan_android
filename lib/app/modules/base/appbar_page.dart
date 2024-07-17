import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/page/base/base_page.dart';

import 'appbar_controller.dart';

class AppbarPage<C extends AppbarController> extends BasePage<C> {
  const AppbarPage({super.key});

  @override
  Widget buildPage(BuildContext context) => buildObx(
      builder: () => NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: _buildTitle(),
                  centerTitle: false,
                  bottom: _buildTabBar(),
                  snap: true,
                  pinned: true,
                  floating: true,
                ),
              ];
            },
            body: _buildInnerBodyView(),
          ));

  Widget? _buildTitle() {
    final title = controller.title;
    if (title != null) {
      return Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500));
    }
    return null;
  }

  PreferredSizeWidget? _buildTabBar() {
    if (controller.isShowTab) {
      return TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        tabs: controller.buildTabs(),
        controller: controller.tabController,
      );
    }

    return null;
  }

  Widget _buildInnerBodyView() {
    if (controller.isShowTab) {
      return TabBarView(
        controller: controller.tabController,
        children: controller.buildTabPages(),
      );
    } else {
      return buildBodyPage();
    }
  }

  Widget buildBodyPage() => const SizedBox.shrink();
}
