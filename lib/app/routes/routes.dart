import 'package:flutter_wan_android/app/modules/page/root/root_binding.dart';
import 'package:flutter_wan_android/app/modules/page/root/root_page.dart';
import 'package:get/get.dart';

abstract class _Paths {
  static const root = '/';
  static const home = '/home';
  static const project = '/project';
  static const series = '/series';
  static const platform = '/platform';
}

/// 路由管理器
class Routes {
  static const root = _Paths.root;

  static const home = _Paths.home;
  static const project = _Paths.project;
  static const series = _Paths.series;
  static const platform = _Paths.platform;

  static final routes = [
    GetPage(name: root, page: () => const RootPage(), binding: RootBinding()),
    // GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
  ];

  /// 封装跳转页面方法
  static to(String path, {dynamic arguments, int? id}) {
    Get.toNamed(path, arguments: arguments, id: id);
  }

  /// 页面回退
  static back<T>({T? result}) {
    Get.back(result: result);
  }
}
