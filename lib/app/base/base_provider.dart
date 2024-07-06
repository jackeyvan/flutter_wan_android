import 'package:get/get.dart';

import '../../core/log/log.dart';
import '../api/api_paths.dart';
import 'base_model.dart';

/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : 远程请求的基类
/// ================================

abstract class BaseProvider extends GetConnect {
  // final devApiUrl = "http://192.168.0.31:8080";
  // final testApiUrl = "http://101.36.105.73:1339";
  final proApiUrl = ApiPaths.baseUrl;

  final defaultPageSize = 20;

  final _headers = <String, dynamic>{};

  @override
  void onInit() {
    addCommonHeaders();
    httpClient.baseUrl = apiUrl();
    httpClient.timeout = const Duration(seconds: 10);

    // httpClient.defaultDecoder = (json) => BaseModel.fromJson(json);

    httpClient.addRequestModifier<Object?>((request) {
      _headers.forEach((key, value) => request.headers.addIf(true, key, value));

      Log.i("REQUEST SUCCESS"
          "REQUEST METHOD：${request.method}\n"
          "REQUEST URL：${request.url}\n"
          "REQUEST HEADERS：${request.headers.toString()}");
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      Log.i("RESPONSE SUCCESS\n"
          "RESPONSE URL：${response.request?.url.toString()}\n"
          "RESPONSE HEADERS：${response.headers.toString()}\n"
          "RESPONSE BODY：${response.body.toString()}");

      return response;
    });
  }

  /// 请求的URL，如果要换的话，可以重写本方法
  String apiUrl() => proApiUrl;

  void addHeaders({String? key, String? value, Map<String, dynamic>? headers}) {
    if (key != null && key.isNotEmpty && value != null && value.isNotEmpty) {
      _headers.addIf(true, key, value);
    }
    if (headers != null && headers.isNotEmpty) {
      _headers.addAllIf(true, headers);
    }
  }

  void addCommonHeaders() {
    // addHeaders(key: "accept", value: "application/json");
    // addHeaders(key: "x-token", value: User.getUser()?.token);
  }

  BaseModel? jsonDecoder(json) => BaseModel.fromJson(json);

  bool isSuccess(BaseModel model) => model.isSuccess();

// Future convert(Future<Response<BaseModel>> response) {
//   try {
//     return response.then((value) {
//       if (value.status.hasError) {
//         return Future.error(ErrorMode.serverError.emsg());
//       } else {
//         if (value.body != null) {
//           BaseModel model = value.body!;
//           if (isSuccess(model)) {
//             return Future.value(value.body!.data);
//           } else {
//             return Future.error(DefaultError(
//                     code: model.code ?? 0,
//                     msg: model.msg ?? ErrorMode.requestError.msg)
//                 .emsg());
//           }
//         } else {
//           return Future.error(ErrorMode.dataError.emsg());
//         }
//       }
//     });
//   } catch (e) {
//     LogUtils.error(e.toString());
//     return Future.error(ErrorMode.requestError.emsg());
//   }
// }
}
