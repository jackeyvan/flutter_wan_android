import 'package:get/get.dart';

import '../../core/service/service.dart';
import '../api/api_provider.dart';

class AppService extends Service {
  @override
  Future<void> init() async {
    /// 本地网络框架，每个url对应一个Provider
    Get.lazyPut(() => ApiProvider().init());
  }
}
