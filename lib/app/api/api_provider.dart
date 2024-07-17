import 'package:dio/dio.dart';
import 'package:flutter_wan_android/core/net/cache_Interceptor.dart';
import 'package:flutter_wan_android/core/net/cache_engine.dart';
import 'package:flutter_wan_android/core/net/net_engine.dart';
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
        connectTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20));

    var dio = Dio(options);

    // /// 设置拦截器
    // /// 网络缓存拦截器
    dio.interceptors.add(CacheInterceptor(
        defaultCacheMode: CacheMode.remoteFirstThenCache,
        defaultExpireTime: const Duration(days: 30)));

    /// 数据解析，默认将text解析成T
    /// 由于官方的transformer只能解析第一层数据，不能解析第二层的Json
    /// 所以需要自己去单独解析
    // dio.transformer = JsonTransformer();

    /// 请求日志打印
    dio.interceptors.add(PrettyDioLogger(request: false, responseBody: false));

    _netEngine = NetEngine(dio,
        defaultCcacheMode: CacheMode.cacheFirstThenRemote,
        defaultCacheExpire: const Duration(days: 30));

    return this;
  }

  /// 登录接口
  // Future<User> login(String username, String password, {String? rePassword}) {
  //   return post(ApiPaths.login,
  //           params: {"username": username, "password": password})
  //       .then((value) => User.fromJson(value));
  // }

  // void logout() {
  //   get(ApiPaths.logout).then((value) {
  //     print("-------> logout $value");
  //   });
  // }
  //
  // /// 注册接口
  // Future<User> register(String username, String password, String rePassword) {
  //   return post(ApiPaths.register, params: {
  //     "username": username,
  //     "password": password,
  //     "repassword": rePassword
  //   }).then((value) => User.fromJson(value));
  // }

  /// 搜索热词
  // Future<List<HotKeysModel>> hotKeyWords() => get(ApiPaths.hotKeywords).then(
  //     (value) => List<Map<String, dynamic>>.from(value)
  //         .map((e) => HotKeysModel.fromJson(e))
  //         .toList());

  Future<T> get<T>(String url, {Map<String, dynamic>? params}) => _netEngine
      .get<T>(url, params: params)
      .then((response) => _handleResult(response));

  Future<T> post<T>(String url, {Map<String, dynamic>? params}) => _netEngine
      .post<T>(url, params: params)
      .then((response) => _handleResult(response));

  Future<T> _handleResult<T>(Response<T> response) {
    if (response.statusCode == 200) {
      var result = Result.fromJson(response.data);

      /// 服务端返回成功
      if (result.isSuccess()) {
        return Future.value(result.data);
      } else {
        return Future.error("${result.errorMsg}(${result.errorCode})");
      }
    }
    return Future.error("请求失败(${response.statusCode})");
  }
}
