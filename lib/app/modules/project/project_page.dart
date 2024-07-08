import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'project_controller.dart';

class ProjectPage extends GetView<ProjectController> {
  ProjectPage({this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    /// 为了给每个Page都绑定一个 Controller，需要设置tag
    return GetX<ProjectController>(
        init: ProjectController(id: id),
        tag: id?.toString(),
        builder: (c) => Scaffold(
              body: Text("${c.data.value}$id"),
            ));
  }
}
