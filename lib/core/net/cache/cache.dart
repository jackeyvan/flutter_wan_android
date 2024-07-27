import 'package:flutter_wan_android/core/init/init_core.dart';
import 'package:flutter_wan_android/core/init/storage.dart';

enum CacheMode {
  /// 只使用本地缓存，没有缓存返回null
  cacheOnly,

  /// 先读取缓存，有缓存会先返回一次
  /// 继续请求服务，请求成功后再次返回
  /// TODO 这种缓存策略，需要先返回缓存数据，然后再返回请求数据，返回两次使用目前的Dio异步方法实现不了。
  /// TODO 需要改成Callback方式才行，但是改动后使用不了Future，这里不单独实现本策略，转为[cacheOnly]
  cacheFirstThenRemote,

  ///  不使用缓存
  remoteOnly,

  /// 每次优先请求数据返回并且存入缓存，如果请求失败读取缓存返回
  /// 请求成功了直接返回结果，请求失败了才回去拉取缓存
  remoteFirstThenCache
}

class Cache {
  /// 读取缓存数据
  static T? readCache<T>(String key) {
    var cache = Storage.read<Map<String, dynamic>>(key);

    /// 缓存没有过期
    if (cache != null && !_expired(cache["timestamp"], cache["expire"])) {
      return cache["data"] as T?;
    }
    return null;
  }

  /// 写入数据缓存，有过期时间
  /// 根据缓存时间，需要进行覆盖
  static Future<void> writeCache(String key, dynamic value, int expire) {
    var results = {
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "expire": expire,
      "data": value,
    };
    return Storage.write(key, results);
  }

  /// 根据时间戳判断缓存是否过期
  static bool _expired(int timestamp, int expire) =>
      DateTime.now().millisecondsSinceEpoch - timestamp > expire;

  ///  缓存的Key
  static String cacheKey(String path, {Map<String, dynamic>? params}) {
    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
        path += "$key=$value";
      });
    }
    return md5(path);
  }
}
