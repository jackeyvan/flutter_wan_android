import 'package:fluttertoast/fluttertoast.dart' as fToast;

class Toast {
  static showToast(String? msg) {
    if (msg != null && msg != "") {
      fToast.Fluttertoast.showToast(
          msg: msg,
          timeInSecForIosWeb: 1,
          toastLength: fToast.Toast.LENGTH_SHORT,
          gravity: fToast.ToastGravity.CENTER,
          fontSize: 16.0);
    }
  }
}
