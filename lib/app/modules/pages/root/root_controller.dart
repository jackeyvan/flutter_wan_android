import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/pages/home/home_page.dart';
import 'package:flutter_wan_android/app/modules/pages/platform/platform_page.dart';
import 'package:flutter_wan_android/app/modules/pages/project/project_page.dart';
import 'package:flutter_wan_android/app/modules/pages/tree/tree_page.dart';
import 'package:flutter_wan_android/core/page/base/base_controller.dart';
import 'package:get/get.dart';

class RootController extends BaseController {
  final _currentBottomIndex = 0.obs;

  final pageController = PageController();

  set currentBottomIndex(index) {
    if (currentBottomIndex != index) {
      _currentBottomIndex.value = index;
    }
  }

  int get currentBottomIndex => _currentBottomIndex.value;

  onPageChange(int index) {
    /// 更新索引和页面
    if (index != currentBottomIndex) {
      currentBottomIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
  }

  /// 与底部Bottom绑定的页面
  Widget buildBody() {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        keepWidgetAlive(const HomePage()),
        keepWidgetAlive(const ProjectTabPage()),
        keepWidgetAlive(const TreeTabPage()),
        keepWidgetAlive(const PlatformTabPage()),
      ],
    );
  }
}
