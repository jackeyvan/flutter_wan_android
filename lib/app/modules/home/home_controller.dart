import 'package:get/get.dart';

import '../../api/api_provider.dart';
// import 'home_provider.dart';

class HomeController extends GetxController {
  // final _provider = Get.find<HomeProvider>();/

  final _apiProvider = Get.find<ApiProvider>();

  final testdata = "我是测试数据".obs;

  @override
  void onInit() {
    print("------------> HomeController ---- onInit");
  }

  @override
  void onClose() {
    print("------------> HomeController ---- onClose");
  }

  @override
  void onReady() {
    print("------------> HomeController ---- onReady");
  }

  void loadData() async {
    _apiProvider.banner().then((value) {
      print("------------> HomeController ---- ${value[0].desc}");
    });
  }
}
