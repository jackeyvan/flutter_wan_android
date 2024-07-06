import 'package:flutter_wan_android/app/api/banner_model.dart';
import 'package:flutter_wan_android/app/api/result.dart';

import '../../core/service/api/api_service.dart';
import 'api_paths.dart';

/// 封装应用层的API请求
class ApiProvider {
  /// 初始化本地数据
  Future<void> initData() async {
    var data = await _get(ApiPaths.banner);
    print("----data $data");
  }

  /// Banner数据
  Future<List<BannerModel>> banner() =>
      _get<List<BannerModel>>(ApiPaths.banner).then((e) {
        List<BannerModel> data = [];

        /// TODO 特殊数据自己单独解析
        print(e);

        return Future.value();
      });

  /// 封装最底层的请求
  Future<T> _get<T>(String url, {Cache cache = Cache.cacheFirstThenRemote}) {
    return ApiService.to().get<T>(url, cache: cache).then((response) {
      /// 网络状态码正常
      ///
      if (response.statusCode == 200) {
        var result = toResult(response.data);

        /// 服务端返回成功
        if (result.isSuccess()) {
          return Future.value(result.data);
        }
      }
      return Future.value();
    });
  }

  /// 转换成基本模型
  Result toResult(json) => Result.fromJson(json);

  /// Json格式转换
}
