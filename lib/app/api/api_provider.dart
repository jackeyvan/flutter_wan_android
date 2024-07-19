import 'package:dio/dio.dart';
import 'package:flutter_wan_android/core/net/cache_Interceptor.dart';
import 'package:flutter_wan_android/core/net/net_engine.dart';
import 'package:flutter_wan_android/core/net/net_error.dart';
import 'package:flutter_wan_android/generated/json/base/json_convert_content.dart';
import 'package:get/get.dart' as getx;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_paths.dart';
import 'api_result.dart';

/// 封装应用层的API请求，一个url对应一个Dio实例对象
/// 封装网络请求各种情况
class ApiProvider {
  /// 快速获取引用
  static ApiProvider get to => getx.Get.find<ApiProvider>();

  // Future<LoadBalancer> loadBalancerCreator =
  //     LoadBalancer.create(2, IsolateRunner.spawn);

  late NetEngine _netEngine;

  /// 初始化本地数据
  ///
  ApiProvider init() {
    /// 网络配置
    final options = BaseOptions(
        baseUrl: ApiPaths.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10));

    var dio = Dio(options);

    // /// 设置拦截器
    // /// 网络缓存拦截器
    dio.interceptors.add(CacheInterceptor(
        defaultCacheMode: CacheMode.remoteFirstThenCache,
        defaultExpireTime: const Duration(days: 30)));

    /// 数据解析，默认将text解析成T
    /// 1、官方的transformer只能解析第一层数据，不能解析第二层的Json
    /// 2、加入缓存后，如果请求错误后使用缓存，走不到这里的解析逻辑
    /// 综合以上两点，只能弃用这个方法
    /// dio.transformer = JsonTransformer();

    /// 请求日志打印
    dio.interceptors.add(PrettyDioLogger(
      request: false,
      responseBody: true,
    ));

    _netEngine = NetEngine(dio);

    return this;
  }

  // void logout() {
  //   get(ApiPaths.logout).then((value) {
  //     print("-------> logout $value");
  //   });
  // }
  //

  /// 搜索热词
  // Future<List<HotKeysModel>> hotKeyWords() => get(ApiPaths.hotKeywords).then(
  //     (value) => List<Map<String, dynamic>>.from(value)
  //         .map((e) => HotKeysModel.fromJson(e))
  //         .toList());

  Future<T> get<T>(
    String url, {
    Map<String, dynamic>? params,
    CacheMode? cacheMode,
    Duration? cacheExpire,
  }) =>
      _netEngine
          .get(
            url,
            params: params,
            cacheMode: cacheMode,
            cacheExpire: cacheExpire,
          )
          .then((response) => _handleResult(response));

  Future<T> post<T>(
    String url, {
    Map<String, dynamic>? params,
    CacheMode? cacheMode,
    Duration? cacheExpire,
  }) =>
      _netEngine
          .post(
            url,
            params: params,
            cacheMode: cacheMode,
            cacheExpire: cacheExpire,
          )
          .then((response) => _handleResult(response));

  Future<T> _handleResult<T>(Response response) {
    if (response.statusCode == 200) {
      var result = Result.fromJson(response.data);

      /// 服务端返回成功
      if (result.isSuccess()) {
        try {
          return Future.value(JsonConvert.fromJsonAsT<T>(result.data));
        } catch (error) {
          throw NetError(
              message: NetError.parseError, origin: error.toString());
        }
      } else {
        throw NetError(message: result.errorMsg, code: result.errorCode);
      }
    }
    throw NetError(code: response.statusCode);
  }
}
