import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// 对外暴露的静态类，直接调用存储
class Storage {
  /// init instance.
  static Future<void> init() async {
    await GetStorage.init();

    Get.put(GetStorage());
  }

  /// GetStorage
  static GetStorage get _getStorage => Get.find<GetStorage>();

  static T? read<T>(String key) => _getStorage.read<T>(key);

  static Future<void> write(String key, dynamic value) {
    return _getStorage.write(key, value);
  }

  static Future<void> remove(String key) {
    return _getStorage.remove(key);
  }

  static Future<void> clear() {
    return _getStorage.erase();
  }
}
