import 'error.dart';

/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : TODO
/// ================================

class ErrorMode {
  static final serverError = DefaultError(code: 500, msg: "服务器异常,请重试");
  static final dataError = DefaultError(code: 2000, msg: "服务器数据异常,请重试");
  static final requestError = DefaultError(code: 1000, msg: "请求失败,请重试");
}
