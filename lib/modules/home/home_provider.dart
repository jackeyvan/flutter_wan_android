import '../../core/providers/base_provider.dart';

abstract class IHomeProvider extends BaseProvider {
  Future<String> loadData();
}

class HomeProvider extends IHomeProvider {
  @override
  Future<String> loadData() {
    return Future.value("我是数据");
  }
}
