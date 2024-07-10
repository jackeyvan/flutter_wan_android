import '../../../core/page/refresh/refresh.dart';
import 'model/project_model.dart';
import 'provider/project_provider.dart';

class ProjectController extends GetRefreshListController<ProjectItemModel> {
  final _provider = ProjectProvider();

  final int? id;

  ProjectController({this.id});

  @override
  Future<List<ProjectItemModel>> loadData(int page) =>
      _provider.project(id ?? 0, page).then((value) => value.datas ?? []);
}
