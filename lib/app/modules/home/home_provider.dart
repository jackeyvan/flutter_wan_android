import 'package:dio/dio.dart';
import 'package:flutter_wan_android/core/service/api/api_service.dart';

// import 'package:get/get.dart';

import '../../api/api.dart';
import '../../base/base.dart';

abstract class IHomeProvider extends BaseProvider {
  Future<String> loadData();
}

class HomeProvider extends IHomeProvider {
  @override
  Future<String> loadData() async {
    Response<String> response = await ApiService.to().get<String>(Api.banner);
    print("---------${response.data}");
    return Future.value(response.data);
  }
}
