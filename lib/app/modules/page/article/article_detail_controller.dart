import 'package:flutter_wan_android/app/modules/base/scaffold_controller.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailController());
  }
}

class ArticleDetailController extends ScaffoldController {
  final _webViewController = Get.find<WebViewController>();

  var progress = 0;

  get webViewController => _webViewController;

  @override
  void onInit() {
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            this.progress = progress;
            showSuccessPage();
          },
          onHttpError: (HttpResponseError error) {
            showErrorPage(error.toString());
          },
          onWebResourceError: (WebResourceError error) {
            showErrorPage(error.description);
          },
        ),
      );

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    var args = Get.arguments;

    if (args != null && args is ArticleModel) {
      title = args.title;

      _webViewController.loadRequest(Uri.parse(args.link ?? ""));

      showSuccessPage();
    } else {
      showEmptyPage();
    }
  }
}
