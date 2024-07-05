import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
  Future<void> erase() {
    return _storage.erase();
  }
}
