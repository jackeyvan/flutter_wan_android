import 'package:dio/dio.dart';
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

/// 缓存拦截器
class CacheInterceptor extends Interceptor {
  final CacheMode defaultCacheMode;
  final Duration defaultExpireTime;

  CacheInterceptor(
      {required this.defaultCacheMode, required this.defaultExpireTime});

  ///
  /// 1、不能先返回缓存，然后再继续请求
  /// 2、先返回缓存后，不能使用transform转换数据
  ///
  /// 解决：
  /// 1、获取缓存要放在调用dio之前
  /// 2、拦截器去掉拦截Request
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var cacheMode = options.extra['cacheMode'];
    final key = options.uri.toString();
    options.extra.addAll({"cacheKey": key});

    /// 设置默认的数据
    cacheMode ??= defaultCacheMode.name;
    if (cacheMode == CacheMode.cacheFirstThenRemote.name) {
      /// 暂时不处理，转为[cacheOnly]模式
      cacheMode = CacheMode.cacheOnly;
    }

    /// 只读取缓存数据，不请求网络数据
    else if (cacheMode == CacheMode.cacheOnly.name) {
      /// 直接返回缓存
      final json = await _readCache(key);

      if (json != null) {
        handler.resolve(Response(
          statusCode: 200,
          data: json,
          statusMessage: '获取缓存数据成功',
          requestOptions: RequestOptions(),
        ));
      }
      return;
    }

    /// 继续转发，走正常的请求
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final extra = response.requestOptions.extra;

    final cacheExpire =
        extra['cacheExpire'] ??= defaultExpireTime.inMilliseconds;
    final cacheKey = extra['cacheKey'];

    Map<String, dynamic>? json = response.data;

    /// 请求成功，并且数据正常
    if (response.statusCode == 200 && json != null) {
      /// 保存缓存到本地
      _writeCache(cacheKey ?? '', json, cacheExpire);
    }
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    final cacheMode = extra['cacheMode'] ??= defaultCacheMode.name;

    /// 如果请求失败，则查找本地缓存
    if (cacheMode == CacheMode.remoteFirstThenCache.name) {
      final cacheKey = extra['cacheKey'];
      final json = await _readCache(cacheKey);

      if (json != null) {
        handler.resolve(Response(
          statusCode: 200,
          data: json,
          statusMessage: '获取缓存数据成功',
          requestOptions: RequestOptions(),
        ));
        return;
      }
    }
    super.onError(err, handler);
  }

  /// 读取缓存数据
  T? _readCache<T>(String key) {
    var cache = Storage.read<Map<String, dynamic>>(key);

    /// 缓存没有过期
    if (cache != null && !_expired(cache["timestamp"], cache["expire"])) {
      return cache["data"] as T?;
    }
    return null;
  }

  /// 写入数据缓存，有过期时间
  /// 根据缓存时间，需要进行覆盖
  Future<void> _writeCache(String key, dynamic value, int expire) {
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
