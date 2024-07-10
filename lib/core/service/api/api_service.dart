import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import 'interceptor/cache_Interceptor.dart';

enum Method {
  get,
  post,
}

/// Dio封装管理,网络请求引擎类
class ApiService {
  static ApiService to() => getx.Get.find<ApiService>();

  late Dio _dio;

  final defaultCacheMode = Cache.cacheOnly.name;
  final defaultExpireTime = const Duration(days: 7);

  /// 默认的Dio请求配置，如果需要自定义Dio，只需要设置Dio对象
  Future<ApiService> init() async {
    /// 网络配置
    /// 可以在这里实现公共配置，也可以子类重写initDio方法
    // final options = BaseOptions(
    //     connectTimeout: const Duration(seconds: 20),
    //     sendTimeout: const Duration(seconds: 20),
    //     receiveTimeout: const Duration(seconds: 20),
    //     validateStatus: (code) {
    //       /// 指定这些HttpCode都算成功
    //       if (code == 200) {
    //         return true;
    //       } else {
    //         return false;
    //       }
    //     });
    //
    // _dio = Dio(options);
    //
    // /// 设置Dio的转换器
    // // _dio.transformer = BackgroundTransformer();
    //
    // /// 设置拦截器
    // /// 网络缓存拦截器
    // _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));
    //
    // /// 网络去重拦截器
    // _dio.interceptors.add(DebounceInterceptor());

    return this;
  }

  /// 设置请求的url，使用默认的Dio配置
  set url(String url) => _dio.options.baseUrl = url;

  /// 初始化Dio，如果调用本方法，则网络相关的配置需要在传回来的Dio设置好
  void initDio(Dio dio) => _dio = dio;

  /// Get方法
  Future<Response<T>> get<T>(String url,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      Cache? cache,
      Duration? cacheExpire,
      ProgressCallback? send,
      ProgressCallback? receive,
      CancelToken? cancelToken,
      bool networkDebounce = false,
      bool isShowLoadingDialog = false}) async {
    return _wrapperRequest(url, Method.get, params, headers, cache, cacheExpire,
        send, receive, cancelToken, networkDebounce, isShowLoadingDialog);
  }

  /// POST请求
  Future<Response<T>> post<T>(String url,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      Cache? cache,
      Duration? cacheExpire,
      ProgressCallback? send,
      ProgressCallback? receive,
      CancelToken? cancelToken,
      bool networkDebounce = false,
      bool isShowLoadingDialog = false}) async {
    var map = <String, dynamic>{};
    if (params != null && params.isNotEmpty) {
      map.addAll(params);
    }
    return _wrapperRequest(
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
      Duration? cacheExpire,
      ProgressCallback? send,
      ProgressCallback? receive,
      CancelToken? cancelToken,
      bool networkDebounce,
      bool isShowLoadingDialog) async {
    /// 重置参数
    params ??= <String, dynamic>{};
    headers ??= <String, dynamic>{};

    ///  缓存模式
    headers['cache_mode'] = cache != null ? cache.name : defaultCacheMode;

    ///  缓存过期时间
    headers['cache_expire'] = cacheExpire != null
        ? cacheExpire.inMilliseconds.toString()
        : defaultExpireTime;

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

    return await request();
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
