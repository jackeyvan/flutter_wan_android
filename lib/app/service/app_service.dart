import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/core/init/init_service.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 业务层初始化
class AppService extends Service {
  @override
  Future<void> init() async {
    /// 本地网络框架，每个url对应一个Provider
    Get.lazyPut(() => ApiProvider().init());

    /// 维持一个全局的WebViewController
    Get.put(WebViewController());
  }
}
