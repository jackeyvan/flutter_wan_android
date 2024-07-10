import '../../../api/api_paths.dart';
import '../../../api/api_provider.dart';
import '../model/banner_model.dart';
import '../model/home_article_model.dart';
import '../model/top_article_model.dart';

abstract class IHomeProvider {
  Future<List<BannerModel>> banner();

  Future<List<TopArticleModel>> topArticle();

  Future<HomeArticleModel> homePageArticle(int page);
}

class HomeProvider extends IHomeProvider {
  final _provider = ApiProvider.to;

  /// Banner数据
  @override
  Future<List<BannerModel>> banner() => _provider.get(ApiPaths.banner).then(
      (value) => List<Map<String, dynamic>>.from(value)
          .map((e) => BannerModel.fromJson(e))
          .toList());

  /// 首页文章
  @override
  Future<HomeArticleModel> homePageArticle(int page) => _provider
      .get("${ApiPaths.homePageArticle}$page/json")
      .then((value) => HomeArticleModel.fromJson(value));

  ///  置顶文章
  @override
  Future<List<TopArticleModel>> topArticle() => _provider
      .get(ApiPaths.topArticle)
      .then((value) => List<Map<String, dynamic>>.from(value)
          .map((e) => TopArticleModel.fromJson(e))
          .toList());
}
