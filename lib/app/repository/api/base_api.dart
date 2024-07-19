import 'package:dio/dio.dart';
import 'package:flutter_wan_android/core/net/cache_Interceptor.dart';
import 'package:flutter_wan_android/core/net/net_error.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum Method {
  get,
  post,
}

abstract class BaseApi {
  late Dio _dio;

  BaseApi() {
    BaseOptions options = BaseOptions();

    options.connectTimeout = const Duration(seconds: 10);
    options.receiveTimeout = const Duration(seconds: 10);
    options.sendTimeout = const Duration(seconds: 10);

    _dio = Dio(options);

    /// 请求日志打印
    _dio.interceptors.add(PrettyDioLogger(
      request: false,
      responseBody: true,
    ));

    init(_dio);
  }

  /// 初始化
  void init(Dio dio);

  /// Json转换
  T convert<T>(dynamic json);

  /// 异步请求，同步Dio请求方法
  Future<T> get<T>(
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

  Future<T> post<T>(
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
  Future<T> _request<T>({
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

    Future<Response<T>> future;

    if (method == Method.get) {
      future = _dio.get<T>(url, queryParameters: params, options: options);
    } else {
      future = _dio.post<T>(url,
          data: FormData.fromMap(params ?? <String, dynamic>{}),
          options: options);
    }
    return future.then((response) {
      try {
        /// 子类做一下数据转换
        final data = convert<T>(response.data);
        return Future.value(data);
      } catch (error) {
        throw NetError(message: NetError.parseError, origin: error.toString());
      }

      /// 统一错误类型
    }).onError((error, _) => throw NetError(origin: error.toString()));
  }

  /// Dio 网络下载
  Future<void> downloadFile({
    required String url,
    required String savePath,
    ProgressCallback? receive,
    void Function(bool success, String path)? callback,
  }) async {
    try {
      _dio.download(url, savePath, onReceiveProgress: receive);

      /// 下载成功
      callback?.call(true, savePath);
    } on DioException catch (_) {
      /// 下载失败
      callback?.call(false, savePath);
    }
  }
}

/// 顶层返回的Result
abstract class BaseResponse {
  int? code;
  String? msg;
  dynamic data;

  bool get success;
}
