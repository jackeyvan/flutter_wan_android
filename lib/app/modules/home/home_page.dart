import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/refresh/refresh_list_page.dart';
import 'home_controller.dart';
import 'model/home_article_model.dart';

class HomePage extends GetRefreshListPage<HomeController> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    print("--------> HomePage build ");

    return buildObx(
        builder: () =>
            buildRefreshListView<HomeArticleModel>(itemBuilder: (item, index) {
              return Text("data ${item.desc}");
            }));
  }
}
