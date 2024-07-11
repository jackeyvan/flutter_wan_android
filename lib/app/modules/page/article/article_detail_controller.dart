import 'dart:ui';

import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailController extends GetxController {
  var title = "默认标题".obs;

  late WebViewController _webViewController;

  var progress = 0.obs;

  @override
  void onInit() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("---> 加载中，$progress");
            this.progress.value = progress;
          },
          onPageStarted: (String url) {
            print("---> 开始加载，$url");
          },
          onPageFinished: (String url) {
            print("---> 加载结束，$url");
          },
          onHttpError: (HttpResponseError error) {
            print("---> 加载异常，${error.toString()}");
          },
          onWebResourceError: (WebResourceError error) {
            print("---> 加载异常，${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    super.onInit();
  }

  @override
  void onReady() {
    var args = Get.arguments;

    if (args != null && args is ArticleModel) {
      title.value = args.title ?? "";

      _webViewController.loadRequest(Uri.parse(args.link ?? ""));
    }
  }

  get webViewController => _webViewController;
}
