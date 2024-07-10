import 'package:get/get.dart';

import 'provider/home_provider.dart';

class HomeController extends GetxController {
  final _provider = HomeProvider();

  final data = "我是测试数据Home".obs;

  @override
  void onInit() {
    _provider.banner().then((value) {
      print("------------> HomeController --获取到数据啦-- ${value[0].desc}");

      data.value = value[0].desc ?? "返回成功，但是数据为空";
    });

    _provider.homePageArticle(0);

    _provider.topArticle();
  }
}
