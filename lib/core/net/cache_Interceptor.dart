import 'package:dio/dio.dart';
import 'package:flutter_wan_android/core/net/cache_engine.dart';

/// 缓存拦截器
class CacheInterceptor extends Interceptor {
  final CacheMode defaultCacheMode;
  final Duration defaultExpireTime;
  final CacheEngine cacheEngine = CacheEngine();

  CacheInterceptor(
      {required this.defaultCacheMode, required this.defaultExpireTime});

  /// TODO 缓存策略问题
  /// 1、不能先返回缓存，然后再继续请求
  /// 2、先返回缓存后，不能使用transform转换数据
  ///
  /// 解决：
  /// 1、获取缓存要放在调用dio之前
  /// 2、拦截器去掉拦截Request
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
      final json = await cacheEngine.readCache(key);

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
      final json = await cacheEngine.readCache(key);

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
    // final cacheMode = requestHeaders['cache_mode'] ??= defaultCacheMode.name;
    final cacheExpire =
        requestHeaders['cache_expire'] ??= defaultExpireTime.inMilliseconds;
    final cacheKey = requestHeaders['cache_key'];

    Map<String, dynamic>? json = response.data;

    /// 请求成功，并且数据正常
    if (response.statusCode == 200 && json != null) {
      /// 保存缓存到本地
      /// TODO 写入缓存之前，判断一下内容是否一样，如果一样则跳过，不刷新缓存时间
      cacheEngine.writeCache(cacheKey ?? '', json, cacheExpire);

      print("------> onResponse 请求成功，写入缓存: ${json}");
    }

    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final Map<String, dynamic> requestHeaders = err.requestOptions.headers;

    print("------> 请求异常 onError");

    final cacheMode = requestHeaders['cache_mode'] ??= defaultCacheMode.name;
    // final cacheExpire =
    //     requestHeaders['cache_expire'] ??= defaultExpireTime.inMilliseconds;
    final cacheKey = requestHeaders['cache_key'];

    /// 如果请求失败，则查找本地缓存
    if (cacheMode == CacheMode.remoteFirstThenCache.name) {
      final json = await cacheEngine.readCache(cacheKey);

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
}
