import 'package:get/get.dart';

import 'home_provider.dart';

class HomeController extends GetxController {
  final _provider = Get.find<HomeProvider>();

  RxString? content;

  @override
  void onInit() {
    buildContent();

    super.onInit();
  }

  void buildContent() {
    _provider.loadData().then((value) {
      content?.value = value;
    });
  }

  String get result => content?.value ?? "没有数据";
}
