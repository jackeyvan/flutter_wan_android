import 'package:flutter_wan_android/core/env/build_env.dart';
import 'package:flutter_wan_android/core/log/log.dart';
import 'package:flutter_wan_android/core/storage/storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'api/api_service.dart';

/// 封装过的父类
abstract class Service extends GetxService {
  void init();

  /// 第一次初始化相关服务
  dependencies() async {
    /// 初始化环境
    Get.put(BuildEnv.dev());

    /// 初始化日志
    Get.put(Logger(printer: PrettyPrinter(), filter: DefaultFilter()),
        permanent: true);

    /// 初始化本地存储服务
    Get.put(await StorageService().init(), permanent: true);

    /// TODO 初始化网络框架和缓存策略
    Get.put(await ApiService().init(), permanent: true);

    /// 子类再去初始化
    init();
  }
}
