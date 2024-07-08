import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/refresh/refresh_page.dart';
import 'model/project_model.dart';
import 'project_controller.dart';

class ProjectPage extends GetRefreshPage<ProjectController> {
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
        shrinkWrap: false,
        controller: controller,
        itemBuilder: (item, index) {
          return Card(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: ListTile(
              // contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              title: Text("${item.title}"),
              subtitle: Text("${item.desc}"),
            ),
          );
        },
        onItemClick: (ProjectItemModel item, int index) {
          print("---------->点击了 = $index item:$item");

          // Toast.showToast(item.title);
        },
        // separatorBuilder: (item, index) {
        //   return Divider(
        //     height: 0,
        //     indent: 12,
        //     endIndent: 12,
        //   );
        // },
      ),
    );
  }
}
