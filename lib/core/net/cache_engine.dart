import 'package:flutter_wan_android/core/init/init_core.dart';
import 'package:flutter_wan_android/core/storage/storage.dart';

enum CacheMode {
  /// 只使用本地缓存，没有缓存返回null
  cacheOnly,

  /// 先读取缓存，有缓存会先返回一次
  /// 继续请求服务，请求成功后再次返回
  cacheFirstThenRemote,

  ///  不使用缓存
  remoteOnly,

  /// 每次优先请求数据返回并且存入缓存，如果请求失败读取缓存返回
  /// 请求成功了直接返回结果，请求失败了才回去拉取缓存
  remoteFirstThenCache
}

class CacheEngine {
  String getCacheKey(String url, Map<String, dynamic>? params) {
    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
        url += key + value;
      });
    }
    return md5(url);
  }

  /// 读取缓存数据
  T? readCache<T>(String key) {
    var cache = Storage.read<Map<String, dynamic>>(key);

    /// 缓存没有过期
    if (cache != null && !_expired(cache["timestamp"], cache["expire"])) {
      return cache["data"] as T?;
    }
    return null;
  }

  /// 写入数据缓存，有过期时间
  /// 根据缓存时间，需要进行覆盖
  Future<void> writeCache(String key, dynamic value, int expire) {
    var results = {
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "expire": expire,
      "data": value,
    };
    return Storage.write(key, results);
  }

  /// 根据时间戳判断缓存是否过期
  bool _expired(int timestamp, int expire) =>
      DateTime.now().millisecondsSinceEpoch - timestamp > expire;
}
