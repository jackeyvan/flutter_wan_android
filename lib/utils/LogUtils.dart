import 'package:get/get.dart';
import 'package:logger/logger.dart';

/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : 日志工具类
/// ================================

class LogUtils {
  static final _logger = Get.find<Logger>();

  static void log(dynamic msg) => _logger.i(msg);

  static void info(dynamic msg) => _logger.i(msg);

  static void error(dynamic msg) => _logger.e(msg);

  static void warning(dynamic msg) => _logger.w(msg);
}
