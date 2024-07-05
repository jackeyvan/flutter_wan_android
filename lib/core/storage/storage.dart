import '../services/storage_service.dart';

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

  static Future<void> erase() {
    return StorageService.to.erase();
  }
}
