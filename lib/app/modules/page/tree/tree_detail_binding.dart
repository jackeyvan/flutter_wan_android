import 'package:flutter_wan_android/app/modules/page/tree/tree_controller.dart';
import 'package:get/get.dart';

class TreeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TreeDetailTabController());
  }
}
