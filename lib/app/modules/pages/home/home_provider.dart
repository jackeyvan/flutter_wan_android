import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/banner_model.dart';

abstract class IHomeProvider {
  Future<List<BannerModel>> banner();

  Future<List<ArticleModel>> topArticle();

  Future<ArticleListModel> homePageArticle(int page);
}

class HomeProvider extends IHomeProvider {
  /// Banner数据
  @override
  Future<List<BannerModel>> banner() => ApiProvider.to
      .get(ApiPaths.banner)
      .then((value) => List<Map<String, dynamic>>.from(value)
          .map((e) => BannerModel.fromJson(e))
          .toList());

  /// 首页文章
  @override
  Future<ArticleListModel> homePageArticle(int page) => ApiProvider.to
      .get("${ApiPaths.articleList}$page/json")
      .then((value) => ArticleListModel.fromJson(value));

  ///  置顶文章
  @override
  Future<List<ArticleModel>> topArticle() => ApiProvider.to
      .get(ApiPaths.topArticle)
      .then((value) => List<Map<String, dynamic>>.from(value)
          .map((e) => ArticleModel.fromJson(e))
          .toList());
}
