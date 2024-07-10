import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/page/refresh/refresh.dart';
import 'model/platform_list_model.dart';
import 'platform_controller.dart';

class PlatformPage extends GetRefreshListPage<PlatformController> {
  const PlatformPage({super.key, this.id});

  final int? id;

  @override
  String? get tag => id?.toString();

  @override
  Widget build(BuildContext context) {
    Get.put(PlatformController(id: id), tag: id?.toString());

    return buildObx(
      builder: () => buildRefreshListView<PlatformModel>(
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
