import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/article_tab_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/structure_entity.dart';

abstract class IStructureProvider {
  Future<List<StructureEntity>> treeTabs();

  Future<List<StructureEntity>> naviTabs();

  Future<ArticleListEntity> treeList(int page, int id);
}

class StructureProvider extends IStructureProvider {
  final _provider = ApiProvider.to;

  /// 导航系列数据
  @override
  Future<List<StructureEntity>> naviTabs() =>
      _provider.get<List<NavigateEntity>>(ApiPaths.naviList).then((entities) =>
          entities.map((e) => StructureEntity.transFromNavi(e)).toList());

  /// 学习体系系列数据
  @override
  Future<List<StructureEntity>> treeTabs() => _provider
      .get<List<ArticleTabEntity>>(ApiPaths.treeList)
      .then((entities) =>
          entities.map((e) => StructureEntity.transFromTree(e)).toList());

  @override
  Future<ArticleListEntity> treeList(int page, int id) =>
      _provider.get<ArticleListEntity>("${ApiPaths.articleList}$page/json",
          params: {"cid": id});
}
