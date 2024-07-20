import 'package:flutter_wan_android/core/page/base/base_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchPageController());
  }
}

class SearchPageController extends BaseController {}
