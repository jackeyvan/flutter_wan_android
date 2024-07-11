import 'package:flutter_wan_android/app/modules/page/article/article_detail_binding.dart';
import 'package:flutter_wan_android/app/modules/page/article/article_detail_page.dart';
import 'package:flutter_wan_android/app/modules/page/root/root_binding.dart';
import 'package:flutter_wan_android/app/modules/page/root/root_page.dart';
import 'package:flutter_wan_android/app/modules/page/tree/tree_detail_binding.dart';
import 'package:flutter_wan_android/app/modules/page/tree/tree_page.dart';
import 'package:get/get.dart';

abstract class _Paths {
  static const root = '/';

  // static const home = '/home';
  static const articleDetail = '/articleDetail';
  static const treeDetail = '/treeDetail';
}

/// 路由管理器
class Routes {
  static const root = _Paths.root;

  // static const home = _Paths.home;
  static const articleDetail = _Paths.articleDetail;
  static const treeDetail = _Paths.treeDetail;

  static final routes = [
    GetPage(name: root, page: () => const RootPage(), binding: RootBinding()),
    GetPage(
        name: articleDetail,
        page: () => const ArticleDetailPage(),
        binding: ArticleDetailBinding()),
    GetPage(
        name: treeDetail,
        page: () => const TreeDetailTabPage(),
        binding: TreeDetailBinding()),
  ];

  /// 封装跳转页面方法
  static to(String route, {dynamic args, int? id}) {
    Get.toNamed(route, arguments: args, id: id);
  }

  /// 页面回退
  static back<T>({T? result}) {
    Get.back(result: result);
  }
}
