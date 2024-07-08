import 'package:flutter/material.dart';

/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : TODO
/// ================================

class ErrorPage extends StatelessWidget {
  final String? msg;
  final VoidCallback? onRetry;

  const ErrorPage({Key? key, this.msg, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var error = msg ?? "发生错误啦，请重试";
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(error),
      onRetry == null
          ? Container()
          : Column(children: [
              const SizedBox(height: 36),
              ElevatedButton(
                  onPressed: () => onRetry?.call(), child: const Text("重试"))
            ])
    ]));
  }
}
