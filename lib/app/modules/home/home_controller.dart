import 'package:get/get.dart';

import '../../api/api_provider.dart';
import 'home_provider.dart';

class HomeController extends GetxController {
  final _provider = Get.find<HomeProvider>();

  var currentBottomIndex = 0.obs;

  final _apiProvider = Get.find<ApiProvider>();

  var content = "默认数据".obs;
  var count = 0.obs;

  @override
  void onInit() {
    // loadData();

    super.onInit();
  }

  void loadData() async {
    _provider.loadData().then((value) {
      // print(value);
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

  login() {
    _apiProvider.login("pgtwo", "123456").then((user) {
      print("-------> 登录成功, ${user.nickname}");
    });
  }

  logout() {
    _apiProvider.logout();
  }

  set bottomIndex(index) {
    currentBottomIndex.value = index;
  }

  get bottomIndex => currentBottomIndex.value;
}
