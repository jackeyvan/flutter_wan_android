import 'package:get/get.dart';

import '../../api/api.dart';
import '../../base/base.dart';

abstract class IHomeProvider extends BaseProvider {
  Future<String> loadData();
}

class HomeProvider extends IHomeProvider {
  @override
  Future<String> loadData() async {
    Response data = await get(Api.projectCategory).catchError((e) {
      print("catche error $e");
    }).onError((e, a) {
      print("onError $e");
      print("onErrorStack $a");
      return Future.error(e!);
    });

    print(data.request);
    return Future.value(data.body);
  }
}
