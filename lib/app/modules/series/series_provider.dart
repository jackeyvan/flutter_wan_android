import 'package:flutter_wan_android/app/api/banner_model.dart';

import '../../api/api_paths.dart';
import '../../api/api_provider.dart';

abstract class ISeriesProvider {
  Future<List<BannerModel>> banner();
}

class SeriesProvider extends ISeriesProvider {
  final _provider = ApiProvider.to;

  @override
  Future<List<BannerModel>> banner() {
    return _provider.get(ApiPaths.banner).then((value) =>
        List<Map<String, dynamic>>.from(value)
            .map((e) => BannerModel.fromJson(e))
            .toList());
  }
}
