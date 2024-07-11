import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/page/article/article_detail_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {
  const ArticleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(title: Text(controller.title.value)),
          body: Column(
            children: [
              LinearProgressIndicator(
                  value: controller.progress.value.toDouble()),
              Expanded(
                child: WebViewWidget(controller: controller.webViewController),
              ),
            ],
          ),
        ));
  }
}
