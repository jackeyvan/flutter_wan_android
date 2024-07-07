import 'package:flutter_wan_android/core/log/log.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// 对外暴露的静态类，直接调用SP存储
class Storage {
  static T? read<T>(String key) => StorageService.to.read<T>(key);

  static Future<void> write(String key, dynamic value) {
    return StorageService.to.write(key, value);
  }

  static Future<void> remove(String key) {
    return StorageService.to.remove(key);
  }

  static Future<void> clear() {
    return StorageService.to.clear();
  }

  static T? readCache<T>(String key) {
    return StorageService.to.readCache<T>(key);
  }

  static Future<void> writeCache(String key, dynamic value,
      {Duration? duration}) {
    return StorageService.to.writeCache(key, value, duration);
  }
}

/// 本地化存储服务
class StorageService extends GetxService {
  /// static get service.
  static StorageService get to => Get.find<StorageService>();

  /// SharedPreferences.
  late final GetStorage _storage;

  /// init SharedPreferences instance.
  Future<StorageService> init() async {
    await GetStorage.init();
    _storage = GetStorage();
    return this;
  }

  /// remove any keys
  Future<void> remove(String key) => _storage.remove(key);

  /// 清空所有存储
  Future<void> clear() => _storage.erase();

  /// 写入数据
  Future<void> write(
    String key,
    dynamic value,
  ) =>
      _storage.write(key, value);

  /// 读取数据
  T? read<T>(String key) => _storage.read<T>(key);

  /// 读取缓存数据
  T? readCache<T>(String key) {
    var cache = _storage.read<Map<String, dynamic>>(key);

    /// 缓存没有过期
    if (cache != null) {
      if (!_isExpired(cache["timestamp"], cache["expire"])) {
        return cache["data"] as T?;
      }
    }
    return null;
  }

  /// 写入数据缓存，有过期时间
  /// 根据缓存时间，需要进行覆盖
  Future<void> writeCache(String key, dynamic value, Duration? duration) {
    var results = {
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "expire": duration?.inMilliseconds ?? 0,
      "data": value,
    };

    Log.i("Storage Write: 写入本地缓存成功");
    return _storage.write(key, results);
  }

  /// 根据时间戳判断缓存是否过期
  bool _isExpired(int timestamp, int expire) =>
      DateTime.now().millisecondsSinceEpoch - timestamp > expire;
}
