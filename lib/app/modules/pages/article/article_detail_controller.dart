import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_wan_android/app/modules/base/scaffold_controller.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/core/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailController());
  }
}

class ArticleDetailController extends ScaffoldController<ArticleEntity> {
  InAppWebViewController? _webViewController;

  final _progress = 0.0.obs;

  double get progress => _progress.value;

  String webUrl = "";

  set progress(double progress) => _progress.value = progress;

  final InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: LogUtils.enableLog,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllowFullscreen: true);

  @override
  void onReady() {
    super.onReady();
    var args = Get.arguments;

    if (args != null && args is ArticleEntity) {
      title = args.title ?? "";
      data = args;
      webUrl = args.link ?? "";
      showSuccessPage();
    } else {
      showEmptyPage();
    }
  }

  void reload() {
    _webViewController?.reload();
    showSuccessPage();
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

  /// WebView Controller创建
  void controllerCreate(InAppWebViewController controller) {
    _webViewController = controller;
    // controller.clearCache()
  }
}
