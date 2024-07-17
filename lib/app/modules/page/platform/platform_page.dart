import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/base/appbar_page.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/widget/article_item_widget.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_page.dart';
import 'package:get/get.dart';

import 'platform_controller.dart';

/// 公众号带有Tab页面
class PlatformTabPage extends AppbarPage<PlatformTabController> {
  const PlatformTabPage({super.key});
}

/// 公众号列表页面
class PlatformPage extends GetRefreshPage<PlatformController> {
  const PlatformPage({super.key, this.id});

  final int? id;

  @override
  String? get tag => id?.toString();

  @override
  void dependencies() {
    Get.lazyPut(() => PlatformController(id: id), tag: id?.toString());
  }

  @override
  Widget buildPage(BuildContext context) =>
      buildObxRefreshListPage<ArticleModel>(
        padding: const EdgeInsets.all(8),
        separatorBuilder: (item, index) => const SizedBox(height: 3),
        itemBuilder: (item, index) => ArticleItemWidget(item),
      );
}
