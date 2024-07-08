import 'package:dio/dio.dart';
import 'package:flutter_wan_android/core/core.dart';

import '../api_service.dart';

/// 缓存拦截器
class CacheInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, dynamic> headers = options.headers;
    final String cacheMode = headers['cache_mode'] ?? "";
    final key = options.uri.toString();

    /// 只读取缓存数据，不请求网络数据
    if (cacheMode == Cache.onlyCache.name) {
      /// 直接返回缓存
      final json = await Storage.readCache(key);

      if (json != null) {
        handler.resolve(Response(
          statusCode: 200,
          data: json,
          statusMessage: '获取缓存数据成功',
          requestOptions: RequestOptions(),
        ));
      } else {
        handler.resolve(Response(
          statusCode: 200,
          data: json,
          statusMessage: '获取缓存数据失败',
          requestOptions: RequestOptions(),
        ));
      }

      /// 有缓存用缓存，没缓存使用网络请求的数据并存入缓存
    } else if (cacheMode == Cache.cacheFirstThenRemote.name) {
      final json = await Storage.readCache(key);

      if (json != null) {
        handler.resolve(Response(
          statusCode: 200,
          data: json,
          statusMessage: '获取缓存成功',
          requestOptions: RequestOptions(),
        ));
      } else {
        /// 处理数据缓存需要的请求头
        headers['cache_key'] = key;
        options.headers = headers;

        /// 继续转发，走正常的请求
        handler.next(options);
      }

      /// 用网络请求的数据并存入缓存
    } else if (cacheMode == Cache.remoteFirstThenCache.name) {
      /// 处理数据缓存需要的请求头
      headers['cache_key'] = key;
      options.headers = headers;

      /// 继续转发，走正常的请求
      handler.next(options);

      /// 不满足条件不需要拦截
    } else {
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      /// 成功的时候设置缓存数据放入 headers 中
      /// 响应体中请求体的请求头数据
      final Map<String, dynamic> requestHeaders =
          response.requestOptions.headers;

      if (requestHeaders['cache_mode'] != null) {
        final cacheKey = requestHeaders['cache_key'];
        final cacheMode = requestHeaders['cache_mode'];
        final cacheExpire = requestHeaders['cache_expire'];

        /// 网络请求完成之后获取正常的Json-Map
        Map<String, dynamic> json = response.data;

        // Log.d('Response 中携带缓存处理逻辑 cacheMode ==== > $cacheMode '
        //     'cacheKey ==== > $cacheKey cacheExpire ==== > $cacheExpire');

        Duration? duration;
        if (cacheExpire != null) {
          duration = Duration(milliseconds: int.parse(cacheExpire));
        }

        /// 保存缓存到本地
        Storage.writeCache(cacheKey ?? '', json, duration: duration);
      }
    }

    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }
}
