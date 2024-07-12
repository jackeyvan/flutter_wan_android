import 'dart:async';

import 'package:dio/dio.dart';

import 'cache_Interceptor.dart';

enum Method {
  get,
  post,
}

/// Dio封装管理,网络请求引擎类
class NetService {
  final Dio dio;

  NetService(this.dio);

  /// Get方法
  Future<Response<T>> get<T>(String url,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      CacheMode? cache,
      Duration? cacheExpire,
      ProgressCallback? send,
      ProgressCallback? receive,
      CancelToken? cancelToken,
      bool networkDebounce = false,
      bool isShowLoadingDialog = false}) {
    return _wrapperRequest<T>(
        url,
        Method.get,
        params,
        headers,
        cache,
        cacheExpire,
        send,
        receive,
        cancelToken,
        networkDebounce,
        isShowLoadingDialog);
  }

  /// POST请求
  Future<Response<T>> post<T>(String url,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      CacheMode? cache,
      Duration? cacheExpire,
      ProgressCallback? send,
      ProgressCallback? receive,
      CancelToken? cancelToken,
      bool networkDebounce = false,
      bool isShowLoadingDialog = false}) {
    var map = <String, dynamic>{};
    if (params != null && params.isNotEmpty) {
      map.addAll(params);
    }
    return _wrapperRequest<T>(
        url,
        Method.post,
        params,
        headers,
        cache,
        cacheExpire,
        send,
        receive,
        cancelToken,
        networkDebounce,
        isShowLoadingDialog);
  }

  /// Dio 网络下载
  Future<void> downloadFile({
    required String url,
    required String savePath,
    ProgressCallback? receive,
    CancelToken? cancelToken,
    void Function(bool success, String path)? callback,
  }) async {
    try {
      dio.download(
        url,
        savePath,
        onReceiveProgress: receive,
        cancelToken: cancelToken,
      );

      /// 下载成功
      callback?.call(true, savePath);
    } on DioException catch (_) {
      /// 下载失败
      callback?.call(false, savePath);
    }
  }

  /// 内部封装的请求方法
  Future<Response<T>> _wrapperRequest<T>(
      String url,
      Method method,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      CacheMode? cache,
      Duration? cacheExpire,
      ProgressCallback? send,
      ProgressCallback? receive,
      CancelToken? cancelToken,
      bool networkDebounce,
      bool isShowLoadingDialog) {
    /// 重置参数
    params ??= <String, dynamic>{};
    headers ??= <String, dynamic>{};

    ///  缓存模式
    headers['cache_mode'] = cache?.name;

    ///  缓存过期时间
    headers['cache_expire'] = cacheExpire?.inMilliseconds;

    return _executeRequest<T>(
        url, method, params, headers, send, receive, cancelToken);
  }

  /// 底层封装的Dio请求
  Future<Response<T>> _executeRequest<T>(
    String url,
    Method method,
    Map<String, dynamic> params,
    Map<String, dynamic> headers,
    ProgressCallback? send,
    ProgressCallback? receive,
    CancelToken? cancelToken,
  ) {
    if (method == Method.get) {
      return dio.get<T>(
        url,
        queryParameters: params,
        options: Options(headers: headers),
        onReceiveProgress: receive,
        cancelToken: cancelToken,
      );
    } else {
      return dio.post<T>(
        url,
        data: FormData.fromMap(params),
        options: Options(headers: headers),
        onSendProgress: send,
        onReceiveProgress: receive,
        cancelToken: cancelToken,
      );
    }
  }
}
