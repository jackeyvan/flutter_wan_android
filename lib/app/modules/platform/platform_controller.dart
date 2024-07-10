import 'package:get/get.dart';

import 'provider/platform_provider.dart';

class PlatformController extends GetxController {
  final _provider = PlatformProvider();

  var data = "微信公众号".obs;

  @override
  void onInit() {
    _provider.platformTab().then((value) {
      print("---------> PlatformController tab: ${value[0].name}");
    });

    _provider.platformList(408, 1).then((value) {
      print("---------> PlatformController list: ${value.datas?[0].author}");
    });
  }
}
