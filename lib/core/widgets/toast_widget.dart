import 'package:fluttertoast/fluttertoast.dart' as f_toast;

class Toast {
  static showToast(String? msg) {
    if (msg != null && msg != '') {
      f_toast.Fluttertoast.showToast(
          msg: msg,
          timeInSecForIosWeb: 1,
          toastLength: f_toast.Toast.LENGTH_SHORT,
          gravity: f_toast.ToastGravity.CENTER,
          fontSize: 16.0);
    }
  }
}
