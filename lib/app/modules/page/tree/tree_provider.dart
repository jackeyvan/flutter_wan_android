import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';

import 'model/navi_model.dart';
import 'model/tree_model.dart';

abstract class ITreeProvider {
  Future<List<TreeModel>> treeList();

  Future<List<NaviModel>> naviList();
}

class TreeProvider extends ITreeProvider {
  final _provider = ApiProvider.to;

  /// 导航系列数据
  @override
  Future<List<NaviModel>> naviList() => _provider.get(ApiPaths.naviList).then(
      (value) => List<Map<String, dynamic>>.from(value)
          .map((e) => NaviModel.fromJson(e))
          .toList());

  /// 学习体系系列数据
  @override
  Future<List<TreeModel>> treeList() => _provider.get(ApiPaths.treeList).then(
      (value) => List<Map<String, dynamic>>.from(value)
          .map((e) => TreeModel.fromJson(e))
          .toList());
}
