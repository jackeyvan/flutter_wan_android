import 'package:flutter_wan_android/app/modules/base/scaffold_controller.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailController());
  }
}

class ArticleDetailController extends ScaffoldController<ArticleEntity> {
  late WebViewController _webViewController;

  final _progress = 0.obs;

  WebViewController get webViewController => _webViewController;

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

    if (args != null && args is ArticleEntity) {
      title = args.title ?? "";
      data = args;

      showSuccessPage();
      _webViewController.loadRequest(Uri.parse(args.link ?? ""));
    } else {
      showEmptyPage();
    }
  }

  void reload() {
    _webViewController.reload();
  }

  Future<void> launchInBrowser() async {
    final url = Uri.parse(data?.link ?? "");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchInBrowserView() async {
    final url = Uri.parse(data?.link ?? "");

    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }
}
