import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// 对外暴露的静态类，直接调用SP存储
class Storage {
  static T? read<T>(String key) {
    return StorageService.to.read<T>(key);
  }

  static Future<void> write(String key, dynamic value) {
    return StorageService.to.write(key, value);
  }

  static Future<void> remove(String key) {
    return StorageService.to.remove(key);
  }

  static Future<void> clear() {
    return StorageService.to.clear();
  }
}

/// 本地化存储服务
class StorageService extends GetxService {
  /// static get service.
  static StorageService get to => Get.find();

  /// SharedPreferences.
  late final GetStorage _storage;

  /// init SharedPreferences instance.
  Future<StorageService> init() async {
    await GetStorage.init();
    _storage = GetStorage();
    return this;
  }

  T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> write(String key, dynamic value) {
    return _storage.write(key, value);
  }

  /// remove any keys
  Future<void> remove(String key) {
    return _storage.remove(key);
  }

  /// 清空所有存储
  Future<void> clear() {
    return _storage.erase();
  }
}
