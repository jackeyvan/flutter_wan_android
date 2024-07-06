import 'package:get/get.dart';

import '../../core/service/api/api_service.dart';
import '../../core/service/service.dart';
import '../api/api_paths.dart';
import '../api/api_provider.dart';

class AppService extends Service {
  @override
  Future<void> init() async {
    /// 设置baseurl
    ApiService.to().url = ApiPaths.baseUrl;

    Get.put(ApiProvider().initData());
  }
}
