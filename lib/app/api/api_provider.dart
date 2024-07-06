import 'package:flutter_wan_android/app/api/banner_model.dart';
import 'package:flutter_wan_android/app/api/result.dart';

import '../../core/service/api/api_service.dart';
import 'api.dart';

/// 封装应用层的API请求
class ApiProvider {
  /// 初始化本地数据
  Future<void> loadData() async {
    var data = await _get<List<BannerModel>>(Api.banner);
    print("----data $data");
  }

  Future<T> _get<T>(String url) {
    return ApiService.to()
        .get<T>(url, cache: Cache.cacheFirstThenRemote)
        .then((response) {
      /// 网络状态码正常
      ///
      if (response.statusCode == 200) {
        var result = Result<T>.fromJson(response.data as Map<String, dynamic>);

        /// 服务端返回成功
        if (result.errorCode == 0) {
          print("result.data = ${result.data.runtimeType}");

          return Future.value(result.data);
        }
      }
      return Future.value();
    });
  }
}
