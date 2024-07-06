import 'package:get/get.dart';

import 'home_provider.dart';

class HomeController extends GetxController {
  final _provider = Get.find<HomeProvider>();

  var content = "默认数据".obs;
  var count = 0.obs;

  @override
  void onInit() {
    loadData();

    super.onInit();
  }

  void loadData() {
    _provider.loadData().then((value) {
      print(value);
      content.value = value;
    }).catchError((e) {
      print(e.toString());
    });
  }

  String get data => content.value;

  increat() {
    count++;
  }

  get number => count;
}
