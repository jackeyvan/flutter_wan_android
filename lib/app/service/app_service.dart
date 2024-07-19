import 'package:flutter_wan_android/app/repository/api_provider.dart';
import 'package:flutter_wan_android/core/init/init_service.dart';
import 'package:get/get.dart';

/// 业务层初始化
class AppService extends Service {
  @override
  Future<void> init() async {
    /// 本地网络框架，每个url对应一个Provider
    Get.lazyPut(() => ApiProvider().init());
  }
}
