import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../env/build_env.dart';
import '../log/log.dart';
import '../storage/storage.dart';
import 'api/api_service.dart';

/// 封装过的父类
abstract class Service extends GetxService {
  init();

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
