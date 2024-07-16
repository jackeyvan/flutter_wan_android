import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/page/article/article_detail_controller.dart';
import 'package:flutter_wan_android/app/modules/page/article/article_detail_page.dart';
import 'package:flutter_wan_android/app/modules/page/root/root_page.dart';
import 'package:flutter_wan_android/app/modules/page/theme/theme_controller.dart';
import 'package:flutter_wan_android/app/modules/page/theme/theme_page.dart';
import 'package:flutter_wan_android/app/modules/page/tree/tree_controller.dart';
import 'package:flutter_wan_android/app/modules/page/tree/tree_page.dart';
import 'package:flutter_wan_android/app/test/test_page.dart';
import 'package:get/get.dart';

abstract class _Paths {
  static const root = '/';

  // static const home = '/home';
  static const articleDetail = '/articleDetail';
  static const treeDetail = '/treeDetail';
  static const themeChose = '/themeChose';
  static const test = '/test';
}

/// 路由管理器
class Routes {
  static const root = _Paths.root;

  // static const home = _Paths.home;
  static const articleDetail = _Paths.articleDetail;
  static const treeDetail = _Paths.treeDetail;
  static const themeChose = _Paths.themeChose;
  static const test = _Paths.test;

  static final routes = [
    GetPage(name: root, page: () => const RootPage()),
    GetPage(name: test, page: () => const TestPage()),
    GetPage(
        name: articleDetail,
        page: () => const ArticleDetailPage(),
        binding: ArticleDetailBinding()),
    GetPage(
        name: treeDetail,
        page: () => const TreeDetailTabPage(),
        binding: TreeDetailBinding()),
    GetPage(
        name: themeChose,
        page: () => const ThemePage(),
        binding: ThemeBinding()),
  ];

  /// 封装跳转页面方法
  static to(String route, {dynamic args, int? id}) {
    Get.toNamed(route, arguments: args, id: id);
  }

  /// 页面回退
  static back<T>({T? result}) {
    Get.back(result: result);
  }

  static openDrawer() {
    final context = Get.context;
    if (context != null) {
      Scaffold.of(context).openDrawer();
    }
  }
}
