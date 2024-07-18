import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/page/root/drawer_page.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/base/base_page.dart';
import 'package:get/get.dart';

import 'root_controller.dart';

class RootPage extends BasePage<RootController> {
  const RootPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Routes.to(Routes.themeChose);
              Routes.toNamed(Routes.login);
              // Routes.to(Routes.language);
            },
            child: const Icon(Icons.add)),
        drawer: const Drawer(child: DrawerPage()),
        bottomNavigationBar: Obx(() => _buildBottomNavigationBar()),
        body: controller.buildBody());
  }

  /// 生成底部Bar
  BottomNavigationBar _buildBottomNavigationBar() {
    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.propane_outlined), label: "项目"),
      const BottomNavigationBarItem(icon: Icon(Icons.call_split), label: "体系"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.adjust_outlined), label: "公众号"),
    ];

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: items,
        onTap: (index) => controller.onPageChange(index),
        currentIndex: controller.currentBottomIndex);
  }
}
