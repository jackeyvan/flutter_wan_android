import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/refresh/refresh_list_page.dart';
import 'project_controller.dart';

class ProjectPage extends GetRefreshListPage<ProjectController> {
  const ProjectPage({this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    /// 为了给每个Page都绑定一个 Controller，需要设置tag
    /// 由于数据封装使用不了obs，只能使用GetBuilder，然后手动去update
    var controller = ProjectController(id: id);
    Get.put(controller, tag: id?.toString());

    return buildObx(
      controller: controller,
      builder: () => buildRefreshListView(
        controller: controller,
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
                                padding: EdgeInsets.only(top: 6),
                                child: Text(
                                  "${item.desc}",
                                  maxLines: 5,
                                )))),
                  ],
                ),
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
