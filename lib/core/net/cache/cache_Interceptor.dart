import 'package:dio/dio.dart';
import 'package:flutter_wan_android/core/net/cache/cache.dart';

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
    final key = Cache.cacheKey(options.path, params: options.queryParameters);
    options.extra.addAll({"cacheKey": key});

    /// 设置默认的数据
    cacheMode ??= defaultCacheMode.name;
    if (cacheMode == CacheMode.cacheFirstThenRemote.name) {
      /// 暂时不处理，转为[cacheOnly]模式
      cacheMode = CacheMode.cacheOnly;
    }

    /// 只读取缓存数据，不请求网络数据
    else if (cacheMode == CacheMode.cacheOnly.name) {
      /// 无论是否有缓存，都直接返回
      final json = await Cache.readCache(key);
      return handler.resolve(Response(
        statusCode: 200,
        data: json,
        statusMessage: json != null ? "获取缓存数据成功" : "获取缓存数据失败",
        requestOptions: RequestOptions(),
      ));
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
      Cache.writeCache(cacheKey ?? '', json, cacheExpire);
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
      final json = Cache.readCache(cacheKey);

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
}
