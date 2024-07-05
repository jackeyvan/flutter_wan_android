import 'package:get/get.dart';

import 'home_provider.dart';

class HomeController extends GetxController {
  final _provider = Get.find<HomeProvider>();

  var content = "默认数据".obs;
  var count = 0.obs;

  @override
  void onInit() {
    buildContent();

    super.onInit();
  }

  void buildContent() {
    _provider.loadData().then((value) {
      print(value);
      content.value = value;
    });
  }

  String get data => content.value;

  increat() {
    count++;
  }

  get number => count;
}
