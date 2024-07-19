import 'dart:convert';

/// 数据模型的封装
class Result {
  final dynamic data;
  final String? errorMsg;
  final int? errorCode;

  const Result(
      {required this.data, required this.errorMsg, required this.errorCode});

  factory Result.fromJson(dynamic json) {
    return Result(
        data: json['data'],
        errorMsg: json['errorMsg'],
        errorCode: json['errorCode']);
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['data'] = data;
    json['errorMsg'] = errorMsg;
    json['errorCode'] = errorCode;
    return json;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  /// 请求成功
  bool isSuccess() => errorCode == 0;
}
