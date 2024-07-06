import 'package:flutter_wan_android/app/api/api.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:get/get.dart';

import '../../core/service/api/api_service.dart';
import '../../core/service/service.dart';

class AppService extends Service {
  @override
  Future<void> init() async {
    /// 设置baseurl
    ApiService.to().url = Api.baseUrl;

    // Get.lazyPut(() => ApiProvider().loadData());
    Get.put(ApiProvider().loadData());
  }
}
