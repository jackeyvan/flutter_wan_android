import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/base/scaffold_page.dart';
import 'package:flutter_wan_android/app/modules/pages/article/article_detail_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends ScaffoldPage<ArticleDetailController> {
  const ArticleDetailPage({super.key});

  @override
  Widget buildBodyPage() {
    return buildObx(
        builder: () => Column(children: [
              Obx(
                () => Offstage(
                    offstage: controller.progress == 100,
                    child: LinearProgressIndicator(
                        minHeight: 2,
                        value: (controller.progress / 100).toDouble())),
              ),
              Expanded(
                child: WebViewWidget(controller: controller.webViewController),
              )
            ]));
  }

  @override
  List<Widget>? buildActions() {
    return [
      IconButton(
          onPressed: () => controller.reload(),
          icon: const Icon(Icons.refresh)),
      IconButton(
          onPressed: () => controller.launchInBrowserView(),
          icon: const Icon(Icons.open_in_browser_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
    ];
  }
}
