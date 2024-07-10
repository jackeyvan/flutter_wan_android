import '../../../api/api_paths.dart';
import '../../../api/api_provider.dart';
import '../model/platform_list_model.dart';
import '../model/platform_tab_model.dart';

abstract class IPlatformProvider {
  Future<List<PlatformTabModel>> platformTab();

  Future<PlatformListModel> platformList(int id, int page);
}

class PlatformProvider extends IPlatformProvider {
  final _provider = ApiProvider.to;

  @override
  Future<PlatformListModel> platformList(int id, int page) => _provider
      .get("${ApiPaths.wxArticleList}$id/$page/json")
      .then((value) => PlatformListModel.fromJson(value));

  @override
  Future<List<PlatformTabModel>> platformTab() => _provider
      .get(ApiPaths.wxArticleTab)
      .then((value) => List<Map<String, dynamic>>.from(value)
          .map((e) => PlatformTabModel.fromJson(e))
          .toList());
}
