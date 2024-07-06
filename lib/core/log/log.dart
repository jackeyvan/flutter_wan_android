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

  /// 常规日志，不跟环境，直接打印
  static void log(dynamic msg) => _logger.i(msg);

  static void i(dynamic msg) {
    if (enable()) {
      _logger.i(msg);
    }
  }

  static void d(dynamic msg) {
    if (enable()) {
      _logger.d(msg);
    }
  }

  static void e(dynamic msg) {
    if (enable()) {
      _logger.e(msg);
    }
  }

  static void w(dynamic msg) {
    if (enable()) {
      _logger.w(msg);
    }
  }

  static bool enable() => Get.find<BuildEnv>().enableLog();
}

class DefaultFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return Get.find<BuildEnv>().enableLog();
  }
}
