import 'package:get/get.dart';

import '../../api/api_provider.dart';
// import 'home_provider.dart';

class HomeController extends GetxController {
  // final _provider = Get.find<HomeProvider>();/

  final _apiProvider = Get.find<ApiProvider>();

  final data = "我是测试数据Home".obs;

  @override
  void onInit() {
    print("------------> HomeController ---- onInit");

    loadData();
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
      print("------------> HomeController --获取到数据啦-- ${value[0].desc}");

      data.value = value[0].desc ?? "返回成功，但是数据为空";
    });
  }
}
