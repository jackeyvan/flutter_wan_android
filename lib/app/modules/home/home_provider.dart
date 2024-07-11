import '../../api/api_paths.dart';
import '../../api/api_provider.dart';
import '../model/article_model.dart';
import '../model/banner_model.dart';

abstract class IHomeProvider {
  Future<List<BannerModel>> banner();

  Future<List<ArticleModel>> topArticle();

  Future<ArticleListModel> homePageArticle(int page);
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
  Future<ArticleListModel> homePageArticle(int page) => _provider
      .get("${ApiPaths.homePageArticle}$page/json")
      .then((value) => ArticleListModel.fromJson(value));

  ///  置顶文章
  @override
  Future<List<ArticleModel>> topArticle() => _provider
      .get(ApiPaths.topArticle)
      .then((value) => List<Map<String, dynamic>>.from(value)
          .map((e) => ArticleModel.fromJson(e))
          .toList());
}
