import 'package:flutter_wan_android/app/api/banner_model.dart';
import 'package:flutter_wan_android/app/api/hot_keys_model.dart';
import 'package:flutter_wan_android/app/api/result.dart';

import '../../core/service/api/api_service.dart';
import 'api_paths.dart';
import 'top_article_model.dart';

/// 封装应用层的API请求
class ApiProvider {
  /// 初始化本地数据
  Future<void> initData() async {
    await banner();
    await topArticle();
    await hotKeyWords().then((value) {
      print("--------> ${value[0].name}");
    });
  }

  /// 搜索热词
  Future<List<HotKeysModel>> hotKeyWords() => _get(ApiPaths.hotKeywords).then(
      (value) => Future.value(List<Map<String, dynamic>>.from(value)
          .map((e) => HotKeysModel.fromJson(e))
          .toList()));

  ///  置顶文章数据
  Future<List<TopArticleModel>> topArticle() =>
      _get<List<dynamic>>(ApiPaths.topArticle).then((value) => Future.value(
          List<Map<String, dynamic>>.from(value)
              .map((e) => TopArticleModel.fromJson(e))
              .toList()));

  /// Banner数据
  Future<List<BannerModel>> banner() => _get<List<dynamic>>(ApiPaths.banner)
      .then((value) => Future.value(List<Map<String, dynamic>>.from(value)
          .map((e) => BannerModel.fromJson(e))
          .toList()));

  /// 封装最底层的请求
  Future<T> _get<T>(String url, {Cache cache = Cache.cacheFirstThenRemote}) {
    return ApiService.to().get(url, cache: cache).then((response) {
      /// 网络状态码正常
      ///
      if (response.statusCode == 200) {
        var result = Result.fromJson(response.data);

        /// 服务端返回成功
        if (result.isSuccess()) {
          return Future.value(result.data);
        }
      }
      return Future.value();
    });
  }
}
