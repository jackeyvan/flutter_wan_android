import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/banner_entity.dart';

abstract class IHomeProvider {
  Future<List<BannerEntity>> banner();

  Future<List<ArticleEntity>> topArticle();

  Future<ArticleListEntity> homePageArticle(int page);
}

class HomeProvider extends IHomeProvider {
  /// Banner数据
  @override
  Future<List<BannerEntity>> banner() =>
      ApiProvider.to.get<List<BannerEntity>>(ApiPaths.banner);

  /// 首页文章
  @override
  Future<ArticleListEntity> homePageArticle(int page) => ApiProvider.to
      .get<ArticleListEntity>("${ApiPaths.articleList}$page/json");

  ///  置顶文章
  @override
  Future<List<ArticleEntity>> topArticle() =>
      ApiProvider.to.get<List<ArticleEntity>>(ApiPaths.topArticle);
}
