import 'package:dio/dio.dart';
import 'package:flutter_wan_android/app/api/banner_model.dart';
import 'package:flutter_wan_android/app/api/home_article_model.dart';
import 'package:flutter_wan_android/app/api/hot_keys_model.dart';
import 'package:flutter_wan_android/app/api/user_model.dart';
import 'package:flutter_wan_android/core/service/api/interceptor/cache_Interceptor.dart';
import 'package:get/get.dart' as getx;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/service/api/api_service.dart';
import 'api_paths.dart';
import 'result.dart';
import 'top_article_model.dart';

/// 封装应用层的API请求，一个url对应一个Provider
/// 封装网络请求各种情况
class ApiProvider {
  /// 快速获取引用
  static ApiProvider get to => getx.Get.find<ApiProvider>();

  /// 初始化本地数据
  ApiProvider init() {
    /// 网络配置
    final options = BaseOptions(
        baseUrl: ApiPaths.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20));

    var dio = Dio(options);

    /// 设置拦截器
    /// 网络缓存拦截器
    dio.interceptors.add(CacheInterceptor());

    /// 请求日志打印
    dio.interceptors.add(PrettyDioLogger(request: false, responseBody: false));

    /// 数据解析，默认将text解析成T
    /// 由于官方的transformer只能解析第一层数据，不能解析第二层的Json
    /// 所以需要自己去单独解析
    // dio.transformer = JsonTransformer();

    ApiService.to().initDio(dio);

    homePageArticle(0);
    hotKeyWords();
    topArticle();
    banner();

    return this;
  }

  /// 登录接口
  Future<User> login(String username, String password, {String? rePassword}) {
    return post(ApiPaths.login,
            params: {"username": username, "password": password})
        .then((value) => User.fromJson(value));
  }

  void logout() {
    get(ApiPaths.logout).then((value) {
      print("-------> logout $value");
    });
  }

  /// 注册接口
  Future<User> register(String username, String password, String rePassword) {
    return post(ApiPaths.register, params: {
      "username": username,
      "password": password,
      "repassword": rePassword
    }).then((value) => User.fromJson(value));
  }

  /// 首页文章
  Future<HomeArticleModel> homePageArticle(int page) =>
      get("${ApiPaths.homePageArticle}$page/json")
          .then((value) => HomeArticleModel.fromJson(value));

  /// 搜索热词
  Future<List<HotKeysModel>> hotKeyWords() => get(ApiPaths.hotKeywords).then(
      (value) => List<Map<String, dynamic>>.from(value)
          .map((e) => HotKeysModel.fromJson(e))
          .toList());

  ///  置顶文章数据
  Future<List<TopArticleModel>> topArticle() => get(ApiPaths.topArticle).then(
      (value) => List<Map<String, dynamic>>.from(value)
          .map((e) => TopArticleModel.fromJson(e))
          .toList());

  /// Banner数据
  Future<List<BannerModel>> banner() => get(ApiPaths.banner).then((value) =>
      List<Map<String, dynamic>>.from(value)
          .map((e) => BannerModel.fromJson(e))
          .toList());

  /// 封装最底层的Get请求
  Future<T> get<T>(String url,
      {Map<String, dynamic>? params,
      Cache cache = Cache.cacheFirstThenRemote}) {
    return _convert(ApiService.to().get(url, params: params, cache: cache));
  }

  /// 封装最底层的Post请求
  Future<T> post<T>(String url,
      {required Map<String, dynamic> params,
      Cache cache = Cache.cacheFirstThenRemote}) {
    return _convert<T>(ApiService.to().post(url, params: params, cache: cache));
  }

  Future<T> _convert<T>(Future<Response<dynamic>> future) {
    return future.then((response) {
      if (response.statusCode == 200) {
        var result = Result.fromJson(response.data);

        print("-------> result: ${result.runtimeType}");

        /// 服务端返回成功
        if (result.isSuccess()) {
          /// TODO 解析数据

          print("-------> data: ${result.data.runtimeType}");

          return result.data;
        }
      }
      return Future.value();
    });
  }
}
