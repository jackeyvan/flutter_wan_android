import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_page.dart';
import 'package:flutter_wan_android/core/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'platform_controller.dart';

/// 公众号带有Tab页面
class PlatformTabPage extends GetView<PlatformTabController> {
  const PlatformTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlatformTabController());

    return controller.obx((tabs) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: AppBar(
              bottom: TabBar(
                labelStyle: TextStyle(fontSize: 15),
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: buildTabs(),
                controller: controller.tabController,
              ),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: buildPages(),
          ),
        ));
  }

  List<Tab> buildTabs() =>
      controller.tabs.map((tab) => Tab(text: tab.name)).toList();

  List<Widget> buildPages() => controller.tabs
      .map((tab) => KeepAliveWrapper(child: PlatformPage(id: tab.id)))
      .toList();
}

/// 公众号列表页面
class PlatformPage extends GetRefreshListPage<PlatformController> {
  const PlatformPage({super.key, this.id});

  final int? id;

  @override
  String? get tag => id?.toString();

  @override
  Widget build(BuildContext context) {
    Get.put(PlatformController(id: id), tag: id?.toString());

    return buildObx(
      builder: () => buildRefreshListView<ArticleModel>(
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
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          "${item.desc}",
                          maxLines: 5,
                        ))),
                onTap: () {
                  print("---------->点击了 = $index item:$item");
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
