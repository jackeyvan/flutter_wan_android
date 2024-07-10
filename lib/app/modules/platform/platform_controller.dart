import '../../../core/page/refresh/refresh.dart';
import 'model/platform_list_model.dart';
import 'provider/platform_provider.dart';

class PlatformController extends GetRefreshListController<PlatformModel> {
  final _provider = PlatformProvider();

  final int? id;

  PlatformController({this.id});

  @override
  Future<List<PlatformModel>> loadData(int page) {
    return _provider.platformList(id ?? 0, page).then((e) => e.datas ?? []);
  }
}
