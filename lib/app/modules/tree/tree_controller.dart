import 'package:get/get.dart';

import 'tree_provider.dart';

class TreeController extends GetxController {
  final _provider = TreeProvider();

  var data = "默认数据Series".obs;

  @override
  void onInit() {
    _provider.treeList().then((value) {
      print("---------> PlatformController tab: ${value[0].name}");
    });

    _provider.naviList().then((value) {
      print("---------> PlatformController list: ${value[0].name}");
    });
  }
}
