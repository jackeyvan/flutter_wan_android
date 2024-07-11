import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/core/service/init_service.dart';
import 'package:get/get.dart';

class AppService extends Service {
  @override
  Future<void> init() async {
    /// 本地网络框架，每个url对应一个Provider
    Get.lazyPut(() => ApiProvider().init());
  }
}
