import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wan_android/app/modules/entity/user_entity.dart';
import 'package:flutter_wan_android/app/repository/api/base_api.dart';
import 'package:flutter_wan_android/app/repository/wan_android_repository.dart';
import 'package:flutter_wan_android/core/net/cache_Interceptor.dart';
import 'package:flutter_wan_android/core/net/net_error.dart';
import 'package:flutter_wan_android/generated/json/base/json_convert_content.dart';

/// 玩安卓的API初始化
class WanAndroidApi extends BaseApi {
  @override
  void init(Dio dio) {
    dio.options.baseUrl = WanAndroidApiPaths.baseUrl;

    /// 缓存拦截器
    dio.interceptors.add(CacheInterceptor(
        defaultCacheMode: CacheMode.remoteFirstThenCache,
        defaultExpireTime: const Duration(days: 30)));

    /// Cookie持久化
    dio.interceptors.add(CookieManager(PersistCookieJar()));

    /// 添加业务拦截器，公共参数和解析等
    dio.interceptors.add((ApiInterceptor()));
  }

  /// 数据转换
  @override
  T convert<T>(json) {
    final data = JsonConvert.fromJsonAsT<T>(json);

    /// 返回成功，但是data没有具体数据，这里使用字符串作为PlaceHolder
    return data ?? "" as T;
  }
}

/// 业务拦截器，添加具体的公共参数
class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['version'] = "1.0.0";
    options.headers['platform'] = "android";

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    final statusCode = response.statusCode;

    if (response.statusCode == 200 && data != null) {
      var result = ApiResponse.fromJson(response.data);
      if (result.success) {
        response.data = result.data;
        super.onResponse(response, handler);
      } else {
        /// 请求不成功
        if (result.code == -1001) {
          /// Cookie过期，清除本地Cookie和用户信息
          User.clear();
        }
        throw NetError(message: result.msg, code: result.code);
      }
    } else {
      throw NetError(code: statusCode);
    }
  }
}

/// 响应基类转换
class ApiResponse extends BaseResponse {
  @override
  bool get success => code == 0;

  ApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    msg = json['errorMsg'];
    data = json['data'];
  }
}
