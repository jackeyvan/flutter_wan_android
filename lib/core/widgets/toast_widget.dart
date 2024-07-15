import 'package:fluttertoast/fluttertoast.dart' as fToast;
import 'package:get/get.dart';

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

  static showSnackBar(String? msg) {
    if (msg != null && msg != "") {
      Get.showSnackbar(GetSnackBar(title: msg));
    }
  }
}
