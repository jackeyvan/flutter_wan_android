import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(HomeProvider());
    // Get.put(HomeController());

    // Get.lazyPut(() => HomeProvider());
    Get.lazyPut(() => HomeController());
  }
}
