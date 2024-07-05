import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../env/build_env.dart';
import '../storage/storage.dart';

class GlobeConfig {
  /// init binding
  static dependencies() async {
    /// init env
    Get.put(BuildEnv.dev());

    /// bind log
    Get.put(Logger(printer: PrettyPrinter(), filter: DefaultFilter()),
        permanent: true);

    /// binding storage service.
    Get.put(await StorageService().init(), permanent: true);
  }
}

class DefaultFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return Get.find<BuildEnv>().enableLog();
  }
}
