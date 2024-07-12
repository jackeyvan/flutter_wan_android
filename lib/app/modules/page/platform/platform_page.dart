import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_page.dart';
import 'package:flutter_wan_android/core/page/tab/tab_page.dart';
import 'package:get/get.dart';

import 'platform_controller.dart';
import 'platform_provider.dart';

/// 公众号带有Tab页面
class PlatformTabPage extends GetTabPage<PlatformTabController> {
  const PlatformTabPage({super.key});

  @override
  void dependencies() {
    Get.lazyPut(() => PlatformProvider());
    Get.lazyPut(() => PlatformTabController());
  }
}

/// 公众号列表页面
class PlatformPage extends GetRefreshListPage<PlatformController> {
  const PlatformPage({super.key, this.id});

  final int? id;

  @override
  String? get tag => id?.toString();

  @override
  void dependencies() {
    Get.lazyPut(() => PlatformController(id: id), tag: id?.toString());
  }

  @override
  Widget buildRefresh() => buildRefreshListView<ArticleModel>(
        padding: const EdgeInsets.only(top: 6),
        itemBuilder: (item, index) {
          return Container(
            /// 设置左上右下的边距，顶部的边距需要Listview自己设置
            margin: const EdgeInsets.fromLTRB(6, 0, 6, 6),
            child: Card(
              /// 卡片的圆角，和水波纹匹配
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: InkWell(
                /// 点击水波纹的圆角
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: ListTile(
                    title: Text(
                      "${item.title}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "${item.desc}",
                          maxLines: 5,
                        ))),
                onTap: () => Routes.to(Routes.articleDetail, args: item),
              ),
            ),
          );
        },
      );
}
