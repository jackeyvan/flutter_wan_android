import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../env/build_env.dart';

/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : 日志工具类
/// ================================

class Log {
  static final _logger = Get.find<Logger>();

  static void i(dynamic msg) => _logger.i(msg);

  static void d(dynamic msg) => _logger.d(msg);

  static void e(dynamic msg) => _logger.e(msg);

  static void w(dynamic msg) => _logger.w(msg);

  static bool enable() => Get.find<BuildEnv>().enableLog();
}

class DefaultFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return Get.find<BuildEnv>().enableLog();
  }
}
