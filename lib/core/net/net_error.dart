class NetError implements Exception {
  String? message;
  final int? code;

  final String defaultError = "请求失败";

  /// 获取原始错误信息
  final String? origin;

  NetError({
    this.message,
    this.code,
    this.origin,
  });

  @override
  String toString() {
    message ??= defaultError;
    final error = code == null ? message : "$message($code)";
    return error ?? defaultError;
  }
}
