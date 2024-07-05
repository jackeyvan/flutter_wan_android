/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : TODO
/// ================================

class DefaultError {
  DefaultError({required this.code, required this.msg});

  int code;
  String msg;

  String emsg() {
    return "$msg($code)";
  }
}
