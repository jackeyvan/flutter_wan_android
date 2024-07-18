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
  late WebViewController _webViewController;

  final _progress = 0.obs;

  get webViewController => _webViewController;

  get progress => _progress.value;

  @override
  void onInit() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            _progress.value = progress;
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
      title = args.title ?? "";

      showSuccessPage();
      _webViewController.loadRequest(Uri.parse(args.link ?? ""));
    } else {
      showEmptyPage();
    }
  }
}
