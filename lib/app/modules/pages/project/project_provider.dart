import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/article_tab_entity.dart';

abstract class IProjectProvider {
  Future<List<ArticleTabEntity>> projectTabs();

  Future<ArticleListEntity> projectList(int id, int page);
}

class ProjectProvider extends IProjectProvider {
  @override
  Future<List<ArticleTabEntity>> projectTabs() =>
      ApiProvider.to.get<List<ArticleTabEntity>>(ApiPaths.projectCategory);

  @override
  Future<ArticleListEntity> projectList(int id, int page) =>
      ApiProvider.to.get<ArticleListEntity>("${ApiPaths.projectList}$page/json",
          params: {"cid": id});
}
