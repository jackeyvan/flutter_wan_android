import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_page.dart';
import 'package:flutter_wan_android/core/page/tab/tab_page.dart';
import 'package:get/get.dart';

import 'project_controller.dart';
import 'project_provider.dart';

class ProjectTabPage extends GetTabPage<ProjectTabController> {
  const ProjectTabPage({super.key});

  @override
  void dependencies() {
    Get.lazyPut(() => ProjectProvider());
    Get.lazyPut(() => ProjectTabController());
  }
}

class ProjectPage extends GetRefreshListPage<ProjectController> {
  const ProjectPage({super.key, this.id});

  final int? id;

  /// 指定Controller的Tag
  @override
  String? get tag => id?.toString();

  @override
  void dependencies() {
    /// 为了给每个Page都绑定一个 Controller，需要设置tag
    /// 由于数据封装使用不了obs，只能使用GetBuilder，然后手动去update
    /// 同时因为自定义Tag的原因，直接使用GetView的controller会返回null
    Get.lazyPut(() => ProjectController(id: id), tag: id?.toString());
  }

  @override
  Widget buildPage() => buildRefreshListView<ArticleModel>(
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
      );
}
