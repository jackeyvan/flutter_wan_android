import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/refresh/refresh_page.dart';
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
            controller: controller,
            itemBuilder: (item, index) {
              return SizedBox(
                  height: 60, child: Center(child: Text("${item.desc}")));
            }));
  }
}
