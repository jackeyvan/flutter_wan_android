import 'package:flutter_wan_android/app/modules/page/theme/theme_controller.dart';
import 'package:get/get.dart';

/// 初始化的Binding
///
/// Controller是跟页面绑定的，页面销毁时，Controller也会被销毁
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
  }
}
