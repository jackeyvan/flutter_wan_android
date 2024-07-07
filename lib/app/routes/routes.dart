import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/root/root_binding.dart';
import '../modules/root/root_page.dart';

abstract class _Paths {
  static const root = '/root';
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
    GetPage(name: root, page: () => RootPage(), binding: RootBinding()),
    GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
  ];

  /// 与底部Bottom绑定的页面
  // static Route? bottomTabRoutes(RouteSettings settings) {
  //   switch (settings.name) {
  //     case project:
  //       return GetPageRoute(
  //           settings: settings,
  //           transition: Transition.noTransition,
  //           page: () => ProjectPage(),
  //           binding: ProjectBinding());
  //     case series:
  //       return GetPageRoute(
  //           settings: settings,
  //           transition: Transition.noTransition,
  //           page: () => SeriesPage(),
  //           binding: SeriesBinding());
  //     case platform:
  //       return GetPageRoute(
  //           settings: settings,
  //           transition: Transition.noTransition,
  //           page: () => PlatformPage(),
  //           binding: PlatformBinding());
  //
  //     /// 默认首页
  //     default:
  //       return GetPageRoute(
  //           transition: Transition.noTransition,
  //           settings: settings,
  //           page: () => HomePage(),
  //           binding: HomeBinding());
  //   }
  // }

  /// 封装跳转页面方法
  static to(String path, {dynamic arguments, int? id}) {
    Get.toNamed(path, arguments: arguments, id: id);
  }

  /// 页面回退
  static back<T>({T? result}) {
    Get.back(result: result);
  }
}
