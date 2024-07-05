import '../../utils/LogUtils.dart';

/// ----------------------------
/// @author : shacoc
/// @time   : 2022/4/1 5:10 AM
/// @soft   : IntelliJ IDEA
/// @desc   : TODO
/// ----------------------------

class BaseModel {
  int? code = 0;
  String? message;
  String? msg;
  dynamic data;

  BaseModel.fromJson(Map<String, dynamic> json) {
    LogUtils.log(json);

    code = json['code'];
    message = json['message'];
    data = json['data'];
    msg = json['msg'];
  }

  @override
  String toString() {
    return "{code: $code, message: $message, msg: $msg, data: $data}";
  }

  bool isSuccess() {
    return code == 200;
  }

  bool isFlashSuccess() {
    return code == 0;
  }
}
