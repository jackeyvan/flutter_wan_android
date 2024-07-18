import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';

abstract class IProjectProvider {
  Future<List<ArticleTabModel>> projectTabs();

  Future<ArticleListModel> projectList(int id, int page);
}

class ProjectProvider extends IProjectProvider {
  @override
  Future<List<ArticleTabModel>> projectTabs() => ApiProvider.to
      .get(ApiPaths.projectCategory)
      .then((value) => List<Map<String, dynamic>>.from(value)
          .map((e) => ArticleTabModel.fromJson(e))
          .toList());

  @override
  Future<ArticleListModel> projectList(int id, int page) => ApiProvider.to.get(
      "${ApiPaths.projectList}$page/json",
      params: {"cid": id}).then((value) => ArticleListModel.fromJson(value));
}
