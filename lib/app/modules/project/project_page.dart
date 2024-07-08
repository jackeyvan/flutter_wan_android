import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'project_controller.dart';

class ProjectPage extends GetView<ProjectController> {
  ProjectPage({this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    // Get.put(dependency)

    return GetX<ProjectController>(
        init: ProjectController(id: id),
        builder: (c) => Scaffold(
              body: Text("${c.data.value}$id"),
            ));
  }
}
