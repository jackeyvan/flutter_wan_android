import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_wan_android/app/modules/base/scaffold_controller.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailController());
  }
}

class ArticleDetailController extends ScaffoldController<ArticleEntity> {
  InAppWebViewController? webViewController;

  final _progress = 0.obs;

  int get progress => _progress.value;

  set progress(int progress) => _progress.value = progress;

  @override
  void onReady() {
    super.onReady();
    var args = Get.arguments;

    if (args != null && args is ArticleEntity) {
      title = args.title ?? "";
      data = args;
      final url = args.link ?? "";
      showSuccessPage();
      webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
    } else {
      showEmptyPage();
    }
  }

  void reload() {
    webViewController?.reload();
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
