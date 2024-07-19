import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_wan_android/app/repository/api_result.dart';
import 'package:flutter_wan_android/core/net/net_error.dart';
import 'package:flutter_wan_android/generated/json/base/json_convert_content.dart';

class JsonTransformer extends SyncTransformer {
  JsonTransformer() : super(jsonDecodeCallback: _decodeJson);
}

/// 插件FlutterJsonBeanFactory，可以动态生成Model的fromJson
/// 如果使用该插件，可以在这里解析数据时，动态解析成对应的范型类型
/// 如果没有使用，则手动使用fromJson方法
Future<FutureOr> _decodeJson(String text) async {
  dynamic json;

  if (text.codeUnits.length < 50 * 1024) {
    json = jsonDecode(text);
  }

  json = await compute(jsonDecode, text);

  print("_decodeJson : ${text}");

  var result = Result.fromJson(json);

  if (result.isSuccess()) {
    return JsonConvert.fromJsonAsT(result.data);
  } else {
    throw NetError(message: result.errorMsg, code: result.errorCode);
  }
}
