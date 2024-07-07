import 'package:flutter_wan_android/app/api/banner_model.dart';
import 'package:flutter_wan_android/app/api/home_article_model.dart';
import 'package:flutter_wan_android/app/api/hot_keys_model.dart';
import 'package:flutter_wan_android/app/api/result.dart';
import 'package:flutter_wan_android/app/api/user_model.dart';

import '../../core/service/api/api_service.dart';
import 'api_paths.dart';
import 'top_article_model.dart';

/// 封装应用层的API请求
class ApiProvider {
  /// 初始化本地数据
  Future<void> initData() async {
    // await banner();
    // await topArticle();
    // await hotKeyWords();
    // await homePageArticle(1);
    // login("pgtwo", "123456");

    // logout();
  }

  /// 登录接口
  Future<User> login(String username, String password, {String? rePassword}) {
    return _post(ApiPaths.login,
            params: {"username": username, "password": password})
        .then((value) => User.fromJson(value));
  }

  void logout() {
    _get(ApiPaths.logout).then((value) {
      print("-------> logout $value");
    });
  }

  /// 注册接口
  Future<User> register(String username, String password, String rePassword) {
    return _post(ApiPaths.register, params: {
      "username": username,
      "password": password,
      "repassword": rePassword
    }).then((value) => User.fromJson(value));
  }

  /// 首页文章
  Future<HomeArticleModel> homePageArticle(int page) =>
      _get("${ApiPaths.homePageArticle}$page/json")
          .then((value) => HomeArticleModel.fromJson(value));

  /// 搜索热词
  Future<List<HotKeysModel>> hotKeyWords() => _get(ApiPaths.hotKeywords).then(
      (value) => List<Map<String, dynamic>>.from(value)
          .map((e) => HotKeysModel.fromJson(e))
          .toList());

  ///  置顶文章数据
  Future<List<TopArticleModel>> topArticle() => _get(ApiPaths.topArticle).then(
      (value) => List<Map<String, dynamic>>.from(value)
          .map((e) => TopArticleModel.fromJson(e))
          .toList());

  /// Banner数据
  Future<List<BannerModel>> banner() => _get(ApiPaths.banner).then((value) =>
      List<Map<String, dynamic>>.from(value)
          .map((e) => BannerModel.fromJson(e))
          .toList());

  /// 封装最底层的Get请求
  Future<T> _get<T>(String url, {Cache cache = Cache.cacheFirstThenRemote}) {
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
  Future<T> _post<T>(String url,
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
