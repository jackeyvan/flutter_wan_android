import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/article_tab_entity.dart';

abstract class IPlatformProvider {
  Future<List<ArticleTabEntity>> platformTab();

  Future<ArticleListEntity> platformList(int id, int page);
}

class PlatformProvider extends IPlatformProvider {
  @override
  Future<ArticleListEntity> platformList(int id, int page) => ApiProvider.to
      .get<ArticleListEntity>("${ApiPaths.wxArticleList}$id/$page/json");

  @override
  Future<List<ArticleTabEntity>> platformTab() =>
      ApiProvider.to.get<List<ArticleTabEntity>>(ApiPaths.wxArticleTab);
}
