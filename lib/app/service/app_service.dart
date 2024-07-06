import 'package:flutter_wan_android/app/api/api.dart';

import '../../core/service/api/api_service.dart';
import '../../core/service/service.dart';

class AppService extends Service {
  @override
  void init() {
    /// 设置baseurl
    ApiService.to().url = Api.baseUrl;
  }
}
