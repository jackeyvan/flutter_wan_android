import 'package:flutter_wan_android/app/modules/pages/home/home_controller.dart';
import 'package:flutter_wan_android/app/modules/pages/home/home_provider.dart';
import 'package:flutter_wan_android/app/modules/pages/platform/platform_controller.dart';
import 'package:flutter_wan_android/app/modules/pages/platform/platform_provider.dart';
import 'package:flutter_wan_android/app/modules/pages/project/project_controller.dart';
import 'package:flutter_wan_android/app/modules/pages/project/project_provider.dart';
import 'package:flutter_wan_android/app/modules/pages/root/root_controller.dart';
import 'package:flutter_wan_android/app/modules/pages/tree/tree_controller.dart';
import 'package:flutter_wan_android/app/modules/pages/tree/tree_provider.dart';
import 'package:get/get.dart';

/// 初始化的Binding
///
/// Controller是跟页面绑定的，页面销毁时，Controller也会被销毁
class AppBinding extends Bindings {
  @override
  void dependencies() {
    /// 根页面
    Get.lazyPut(() => RootController());

    /// 首页
    Get.lazyPut(() => HomeProvider());
    Get.lazyPut(() => HomeController());

    /// 项目页面
    Get.lazyPut(() => ProjectProvider());
    Get.lazyPut(() => ProjectTabController());

    /// 体系页面
    Get.lazyPut(() => TreeProvider());
    Get.lazyPut(() => TreeTabController());

    /// 公众号页面
    Get.lazyPut(() => PlatformProvider());
    Get.lazyPut(() => PlatformTabController());
  }
}
