import '../../../core/refresh/refresh_controller.dart';
import 'model/project_model.dart';
import 'provider/project_provider.dart';

class ProjectController extends GetRefreshController<ProjectItemModel> {
  final _provider = ProjectProvider();

  final int? id;

  ProjectController({this.id});

  @override
  int initPage() => 0;

  @override
  Future<List<ProjectItemModel>> loadData(int page) {
    return _provider.project(id ?? 0, page).then((value) => value.datas ?? []);
  }
}
