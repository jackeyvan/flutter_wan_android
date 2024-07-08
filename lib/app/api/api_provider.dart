import 'package:flutter_wan_android/app/api/banner_model.dart';
import 'package:flutter_wan_android/app/api/home_article_model.dart';
import 'package:flutter_wan_android/app/api/hot_keys_model.dart';
import 'package:flutter_wan_android/app/api/result.dart';
import 'package:flutter_wan_android/app/api/user_model.dart';
import 'package:get/get.dart';

import '../../core/service/api/api_service.dart';
import 'api_paths.dart';
import 'top_article_model.dart';

/// 封装应用层的API请求，一个url对应一个Provider
/// 封装网络请求各种情况
class ApiProvider {
  /// 快速获取引用
  static ApiProvider get to => Get.find<ApiProvider>();

  /// 初始化本地数据
  ApiProvider init() {
    /// 初始化网络框架项管参数
    ApiService.to().url = ApiPaths.baseUrl;

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
  Future<T> get<T>(String url, {Cache cache = Cache.cacheFirstThenRemote}) {
    return ApiService.to().get(url, cache: cache).then((response) {
      /// 网络状态码正常
      ///
      if (response.statusCode == 200) {
        var result = Result.fromJson(response.data);

        /// 服务端返回成功
        if (result.isSuccess()) {
          /// TODO 解析数据

          return result.data;
        }
      }
      return Future.value();
    });
  }

  /// 封装最底层的Post请求
  Future<T> post<T>(String url,
      {required Map<String, dynamic> params,
      Cache cache = Cache.cacheFirstThenRemote}) {
    return ApiService.to()
        .post(url, params: params, cache: cache)
        .then((response) {
      /// 网络状态码正常
      if (response.statusCode == 200) {
        var result = Result.fromJson(response.data);

        /// 服务端返回成功
        if (result.isSuccess()) {
          /// TODO 解析数据

          return result.data;
        }
      }
      return Future.value();
    });
  }
}
