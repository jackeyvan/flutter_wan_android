import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '../../log/log.dart';
import 'interceptor/cache_Interceptor.dart';
import 'interceptor/debounce_Interceptor.dart';

enum Cache {
  ///  不使用缓存
  onlyRemote,

  /// 只使用本地缓存，没有缓存返回null
  onlyCache,

  /// 有缓存先用缓存，没有缓存进行网络请求并存入缓存
  cacheFirstThenRemote,

  /// 先去请求数据并存入缓存，请求失败再使用缓存
  remoteFirstThenCache
}

enum Method {
  get,
  post,
}

/// Dio封装管理,网络请求引擎类
class ApiService {
  static ApiService to() => getx.Get.find<ApiService>();

  late Dio _dio;

  Future<ApiService> init() async {
    /// 网络配置
    final options = BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        validateStatus: (code) {
          /// 指定这些HttpCode都算成功
          if (code == 200) {
            return true;
          } else {
            return false;
          }
        });

    _dio = Dio(options);

    /// 设置Dio的转换器
    _dio.transformer = BackgroundTransformer();

    /// 设置拦截器
    /// 网络缓存拦截器
    _dio.interceptors.add(CacheInterceptor());

    /// 网络去重拦截器
    _dio.interceptors.add(DebounceInterceptor());

    return this;
  }

  /// 设置请求的url
  set url(String url) {
    _dio.options.baseUrl = url;
  }

  /// Get方法
  Future<Response<T>> get<T>(String url,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      Cache? cache,
      Duration? duration,
      ProgressCallback? send,
      ProgressCallback? receive,
      CancelToken? cancelToken,
      bool networkDebounce = false,
      bool isShowLoadingDialog = false}) async {
    return _wrapperRequest(url, Method.get, params, headers, cache, duration,
        send, receive, cancelToken, networkDebounce, isShowLoadingDialog);
  }

  /// POST请求
  Future<Response<T>> post<T>(String url,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      Cache? cache,
      Duration? duration,
      ProgressCallback? send,
      ProgressCallback? receive,
      CancelToken? cancelToken,
      bool networkDebounce = false,
      bool isShowLoadingDialog = false}) async {
    var map = <String, dynamic>{};
    if (params != null && params.isNotEmpty) {
      map.addAll(params);
    }
    return _wrapperRequest(url, Method.post, params, headers, cache, duration,
        send, receive, cancelToken, networkDebounce, isShowLoadingDialog);
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
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: receive,
        cancelToken: cancelToken,
      );

      /// 下载成功
      callback?.call(true, savePath);
    } on DioException catch (e) {
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
      Cache? cache,
      Duration? duration,
      ProgressCallback? send,
      ProgressCallback? receive,
      CancelToken? cancelToken,
      bool networkDebounce,
      bool isShowLoadingDialog) async {
    /// 重置参数
    params ??= <String, dynamic>{};
    headers ??= <String, dynamic>{};

    ///  缓存头
    if (cache != null) {
      headers['cache_mode'] = cache.name;

      if (duration != null) {
        headers['cache_expire'] = duration.inMilliseconds.toString();
      }
    }

    /// 网络请求去重，内部逻辑判断发起真正的网络请求
    if (networkDebounce) {
      headers['network_debounce'] = "true";
    }

    if (isShowLoadingDialog) {
      headers['is_show_loading_dialog'] = "true";
    }

    /// 定义一个局部函数，封装重复的请求逻辑
    Future<Response<T>> request() async {
      return _executeRequest(
          url, method, params!, headers!, send, receive, cancelToken);
    }

    try {
      Response<T> response;

      if (Log.enable()) {
        final startTime = DateTime.now();
        response = await request();
        final endTime = DateTime.now();
        final duration = endTime.difference(startTime).inMilliseconds;
        Log.d('网络请求耗时：$duration 毫秒\n'
            'HttpCode：${response.statusCode} \n'
            'HttpMessage：${response.statusMessage} \n'
            '响应内容：${response.data}}');
      } else {
        response = await request();
      }
      return response;
    } on DioException catch (e) {
      Log.e("ApiService - DioException：$e  其他错误Error:${e.error.toString()}");
      return Future.error(e);
    }
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
      return _dio.get(
        url,
        queryParameters: params,
        options: Options(headers: headers),
        onReceiveProgress: receive,
        cancelToken: cancelToken,
      );
    } else {
      return _dio.post(
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
