import 'package:get/get.dart';

import 'series_provider.dart';

class SeriesController extends GetxController {
  final _provider = SeriesProvider();

  var data = "默认数据Series".obs;

  @override
  void onInit() {
    print("------------> SeriesController ---- onInit");

    // _provider.banner().then((value) {
    //   data.value = value[0].title ?? "请求成功，数据为空";
    // });
  }

  @override
  void onClose() {
    print("------------> SeriesController ---- onClose");
  }

  @override
  void onReady() {
    print("------------> SeriesController ---- onReady");
  }
}
