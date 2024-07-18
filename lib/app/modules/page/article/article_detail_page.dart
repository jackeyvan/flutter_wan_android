import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/base/scaffold_page.dart';
import 'package:flutter_wan_android/app/modules/page/article/article_detail_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends ScaffoldPage<ArticleDetailController> {
  const ArticleDetailPage({super.key});

  @override
  Widget buildBodyPage() {
    return Column(children: [
      Obx(
        () => Offstage(
            offstage: controller.progress == 100,
            child: LinearProgressIndicator(
                minHeight: 2, value: (controller.progress / 100).toDouble())),
      ),
      Expanded(
        child: WebViewWidget(controller: controller.webViewController),
      )
    ]);
  }
}
