import '../../../api/api_paths.dart';
import '../../../api/api_provider.dart';
import '../model/project_model.dart';
import '../model/project_tab_model.dart';

abstract class IProjectProvider {
  Future<List<ProjectTabModel>> projectTables();

  Future<ProjectModel> project(int id, int page);
}

class ProjectProvider extends IProjectProvider {
  final _provider = ApiProvider.to;

  @override
  Future<List<ProjectTabModel>> projectTables() {
    return _provider.get(ApiPaths.projectCategory).then((value) {
      print("---------> ${value.runtimeType}");

      return List<Map<String, dynamic>>.from(value)
          .map((e) => ProjectTabModel.fromJson(e))
          .toList();
    });
  }

  @override
  Future<ProjectModel> project(int id, int page) {
    return _provider.get("${ApiPaths.projectList}$page/json",
        params: {"cid": id}).then((value) => ProjectModel.fromJson(value));
  }
}
