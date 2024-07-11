import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_page.dart';
import 'package:flutter_wan_android/core/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'project_controller.dart';

class ProjectTabPage extends GetView<ProjectTabController> {
  const ProjectTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectTabController());

    return controller.obx((tabs) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: AppBar(
              bottom: TabBar(
                labelStyle: const TextStyle(fontSize: 15),
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: buildTabs(tabs),
                controller: controller.tabController,
              ),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: buildPages(tabs),
          ),
        ));
  }

  List<Tab> buildTabs(List<ArticleTabModel>? tabs) =>
      tabs?.map((tab) => Tab(text: tab.name)).toList() ?? [];

  List<Widget> buildPages(List<ArticleTabModel>? tabs) {
    return tabs
            ?.map((tab) => KeepAliveWrapper(child: ProjectPage(id: tab.id)))
            .toList() ??
        [];
  }
}

class ProjectPage extends GetRefreshListPage<ProjectController> {
  const ProjectPage({super.key, this.id});

  final int? id;

  /// 指定Controller的Tag
  @override
  String? get tag => id?.toString();

  @override
  Widget build(BuildContext context) {
    /// 为了给每个Page都绑定一个 Controller，需要设置tag
    /// 由于数据封装使用不了obs，只能使用GetBuilder，然后手动去update
    /// 同时因为自定义Tag的原因，直接使用GetView的controller会返回null
    Get.put(ProjectController(id: id), tag: id?.toString());

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
                child: Row(
                  children: [
                    CachedNetworkImage(
                      width: 80,
                      height: 160,
                      imageUrl: item.envelopePic ?? "",
                      fit: BoxFit.fill,
                    ),
                    Expanded(
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
                                )))),
                  ],
                ),
                onTap: () => Routes.to(Routes.articleDetail, args: item),
              ),
            ),
          );
        },
      ),
    );
  }
}
