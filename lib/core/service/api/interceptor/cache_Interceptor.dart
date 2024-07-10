import 'package:dio/dio.dart';
import 'package:flutter_wan_android/core/core.dart';

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

/// 缓存拦截器
class CacheInterceptor extends Interceptor {
  final CacheMode defaultCacheMode;
  final Duration defaultExpireTime;

  CacheInterceptor(
      {required this.defaultCacheMode, required this.defaultExpireTime});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, dynamic> headers = options.headers;
    var cacheMode = headers['cache_mode'];
    final key = options.uri.toString();

    headers['cache_key'] = key;
    options.headers = headers;

    /// 设置默认的数据
    cacheMode ??= defaultCacheMode.name;

    /// 只读取缓存数据，不请求网络数据
    if (cacheMode == CacheMode.cacheOnly.name) {
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

      /// 有缓存用缓存，没缓存使用网络请求的数据
    } else if (cacheMode == CacheMode.cacheFirstThenRemote.name) {
      final json = await _readCache(key);

      print("------> cache: $cacheMode");
      print("------> read cache data: $json");

      if (json != null) {
        handler.resolve(Response(
          statusCode: 200,
          data: json,
          statusMessage: '获取缓存数据成功',
          requestOptions: RequestOptions(),
        ));

        /// TODO 拦截器要么返回完成请求，要么继续往下走。实现不了先返回缓存，然后再返回网络数据
        return;
      }
    }

    /// 继续转发，走正常的请求
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final Map<String, dynamic> requestHeaders = response.requestOptions.headers;

    print("------> onResponse 请求成功");

    /// 获取默认的CacheMode
    final cacheMode = requestHeaders['cache_mode'] ??= defaultCacheMode.name;
    final cacheExpire =
        requestHeaders['cache_expire'] ??= defaultExpireTime.inMilliseconds;
    final cacheKey = requestHeaders['cache_key'];

    Map<String, dynamic>? json = response.data;

    /// 请求成功，并且数据正常
    if (response.statusCode == 200 && json != null) {
      /// 保存缓存到本地
      /// TODO 写入缓存之前，判断一下内容是否一样，如果一样则跳过，不刷新缓存时间
      _writeCache(cacheKey ?? '', json, cacheExpire);

      print("------> onResponse 请求成功，写入缓存: ${json}");
    }

    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final Map<String, dynamic> requestHeaders = err.requestOptions.headers;

    print("------> 请求异常 onError");

    final cacheMode = requestHeaders['cache_mode'] ??= defaultCacheMode.name;
    final cacheExpire =
        requestHeaders['cache_expire'] ??= defaultExpireTime.inMilliseconds;
    final cacheKey = requestHeaders['cache_key'];

    /// 如果请求失败，则查找本地缓存
    if (cacheMode == CacheMode.remoteFirstThenCache.name) {
      final json = await _readCache(cacheKey);

      if (json != null) {
        handler.resolve(Response(
          statusCode: 200,
          data: json,
          statusMessage: '获取缓存数据成功',
          requestOptions: RequestOptions(),
        ));
      }

      print("------> 请求异常 读取缓存: ${json}");
      return;
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
