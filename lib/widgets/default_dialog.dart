import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultDialog {
  static void show({
    stitle,
    required scontent,
    scancel,
    sconform,
  }) {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      // false = home must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return CustomDialog(
          stitle: stitle,
          scontent: scontent,
          scancel: scancel,
          sconform: sconform,
        );
      },
    );
  }
}

class CustomDialog extends AlertDialog {
  final String? stitle;
  final String scontent;

  VoidCallback? scancel;
  VoidCallback? sconform;

  CustomDialog({
    Key? key,
    this.stitle,
    required this.scontent,
    this.scancel,
    this.sconform,
  }) : super(
            key: key,
            title: Text(stitle ?? "温馨提示"),
            content: Text(scontent),
            actions: [
              TextButton(
                  onPressed: () {
                    if (scancel != null) {
                      scancel.call();
                    } else {
                      Get.back();
                    }
                  },
                  child: const Text("取消")),
              TextButton(
                  onPressed: () {
                    if (sconform != null) {
                      sconform.call();
                    } else {
                      Get.back();
                    }
                  },
                  child: const Text("确定")),
            ]);
}

class LoadingDialog {
  static void show() {
    var context = Get.context;
    if (context != null) {
      showDialog(
          context: Get.context!,
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          builder: (context) {
            return UnconstrainedBox(
              child: SizedBox(
                width: 200,
                child: AlertDialog(
                  backgroundColor: Colors.black87,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text("加载中", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  static void dismiss() {
    var context = Get.context;
    if (context != null) {
      Navigator.pop(context);
    }
  }
}
