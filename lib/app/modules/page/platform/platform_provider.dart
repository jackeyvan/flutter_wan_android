import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';

abstract class IPlatformProvider {
  Future<List<ArticleTabModel>> platformTab();

  Future<ArticleListModel> platformList(int id, int page);
}

class PlatformProvider extends IPlatformProvider {
  final _provider = ApiProvider.to;

  @override
  Future<ArticleListModel> platformList(int id, int page) => _provider
      .get("${ApiPaths.wxArticleList}$id/$page/json")
      .then((value) => ArticleListModel.fromJson(value));

  @override
  Future<List<ArticleTabModel>> platformTab() => _provider
      .get(ApiPaths.wxArticleTab)
      .then((value) => List<Map<String, dynamic>>.from(value)
          .map((e) => ArticleTabModel.fromJson(e))
          .toList());
}
