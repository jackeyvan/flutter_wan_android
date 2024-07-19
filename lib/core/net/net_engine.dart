import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_wan_android/core/net/cache_Interceptor.dart';
import 'package:flutter_wan_android/core/net/net_error.dart';

enum Method {
  get,
  post,
}

/// Dio封装管理,网络请求引擎类
class NetEngine {
  final Dio dio;

  NetEngine(this.dio);

  /// 异步请求，同Dio请求方法
  Future<Response<T>> get<T>(
    String url, {
    Options? options,
    Map<String, dynamic>? params,
    CacheMode? cacheMode,
    Duration? cacheExpire,
  }) =>
      _request<T>(
          url: url,
          method: Method.get,
          params: params,
          options: options,
          cacheMode: cacheMode,
          cacheExpire: cacheExpire);

  Future<Response<T>> post<T>(
    String url, {
    Options? options,
    Map<String, dynamic>? params,
    CacheMode? cacheMode,
    Duration? cacheExpire,
  }) =>
      _request<T>(
          url: url,
          method: Method.post,
          params: params,
          options: options,
          cacheMode: cacheMode,
          cacheExpire: cacheExpire);

  /// 底层封装的Dio请求
  Future<Response<T>> _request<T>({
    required String url,
    required Method method,
    Map<String, dynamic>? params,
    Options? options,
    CacheMode? cacheMode,
    Duration? cacheExpire,
  }) {
    options ??= Options(extra: {});

    /// 更新缓存策略
    if (cacheMode != null) {
      options.extra?.addAll({"cacheMode": cacheMode});
    } else if (cacheExpire != null) {
      options.extra?.addAll({"cacheExpire": cacheExpire.inMilliseconds});
    }

    if (method == Method.get) {
      return dio
          .get<T>(url, queryParameters: params, options: options)
          .onError((error, _) => throw NetError(origin: error.toString()));
    } else {
      return dio
          .post<T>(url,
              data: FormData.fromMap(params ?? <String, dynamic>{}),
              options: options)
          .onError((error, _) => throw NetError(origin: error.toString()));
    }
  }

  /// Dio 网络下载
  Future<void> downloadFile({
    required String url,
    required String savePath,
    ProgressCallback? receive,
    void Function(bool success, String path)? callback,
  }) async {
    try {
      dio.download(url, savePath, onReceiveProgress: receive);

      /// 下载成功
      callback?.call(true, savePath);
    } on DioException catch (_) {
      /// 下载失败
      callback?.call(false, savePath);
    }
  }
}
