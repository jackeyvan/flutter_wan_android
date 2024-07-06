import '../../base/base.dart';

abstract class IHomeProvider extends BaseProvider {
  Future<String> loadData();
}

class HomeProvider extends IHomeProvider {
  @override
  Future<String> loadData() async {
    // Response<String> response = await ApiService.to().get<String>(Api.banner);
    // print("---------${response.data}");
    return Future.value('');
  }
}
