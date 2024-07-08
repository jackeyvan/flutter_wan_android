import 'package:get/get.dart';

import 'provider/project_provider.dart';

class ProjectController extends GetxController {
  final _provider = ProjectProvider();

  final data = "我是测试数据".obs;

  final int? id;

  ProjectController({this.id});

  @override
  void onInit() {
    super.onInit();

    _provider.project(id ?? 0, 1).then((value) {
      data.value = value.datas![0].desc ?? "请求成功，但是数据为空";
    });

    print("------------->ProjectController onInit $id----------");
  }

  @override
  void onReady() {
    print("------------->ProjectController onReady----$id------");
    super.onReady();
  }

  @override
  void onClose() {
    print("------------->ProjectController onClose-----$id-----");
    super.onClose();
  }
}
