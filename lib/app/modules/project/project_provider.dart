import '../../api/api_paths.dart';
import '../../api/api_provider.dart';
import 'model/project_tab_model.dart';

abstract class IProjectProvider {
  Future<List<ProjectTabModel>> projectTables();
}

class ProjectProvider extends IProjectProvider {
  final _provider = ApiProvider.to;

  @override
  Future<List<ProjectTabModel>> projectTables() {
    return _provider.get(ApiPaths.projectCategory).then((value) =>
        List<Map<String, dynamic>>.from(value)
            .map((e) => ProjectTabModel.fromJson(e))
            .toList());
  }
}
