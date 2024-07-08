import 'package:get/get.dart';

import 'platform_provider.dart';

class PlatformController extends GetxController {
  final _provider = PlatformProvider();

  var data = "微信公众号".obs;

  @override
  void onInit() {
    print("------------> PlatformController ---- onInit");

    // _provider.banner().then((value) {
    //   data.value = value[0].title ?? "请求成功，但是数据为空";
    // });
  }

  @override
  void onClose() {
    print("------------> PlatformController ---- onClose");
  }

  @override
  void onReady() {
    print("------------> PlatformController ---- onReady");
  }
}
