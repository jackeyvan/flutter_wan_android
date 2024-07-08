import 'package:get/get.dart';

import 'platform_controller.dart';

class PlatformBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlatformController());
  }
}
