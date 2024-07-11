import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';
import 'package:flutter_wan_android/app/modules/model/tree_model.dart';

abstract class ITreeProvider {
  Future<List<TreeModel>> treeTabs();

  Future<List<TreeModel>> naviTabs();
}

class TreeProvider extends ITreeProvider {
  final _provider = ApiProvider.to;

  /// 导航系列数据
  @override
  Future<List<TreeModel>> naviTabs() => _provider.get(ApiPaths.naviList).then(
      (value) => List<Map<String, dynamic>>.from(value)
          .map((e) => TreeModel.transFromNavi(NaviTabModel.fromJson(e)))
          .toList());

  /// 学习体系系列数据
  @override
  Future<List<TreeModel>> treeTabs() => _provider.get(ApiPaths.treeList).then(
      (value) => List<Map<String, dynamic>>.from(value)
          .map((e) => TreeModel.transFromTree(ArticleTabModel.fromJson(e)))
          .toList());
}
