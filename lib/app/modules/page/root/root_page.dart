import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/page/home/home_page.dart';
import 'package:flutter_wan_android/app/modules/page/platform/platform_page.dart';
import 'package:flutter_wan_android/app/modules/page/project/project_page.dart';
import 'package:flutter_wan_android/app/modules/page/tree/tree_page.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'root_controller.dart';

class RootPage extends GetView<RootController> {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => Routes.to(Routes.themeChose),
            child: const Icon(Icons.add)),
        drawer: _buildNavigationDrawer(),
        bottomNavigationBar: Obx(() => _buildBottomNavigationBar()),
        body: _buildBody());
  }

  /// 生成底部Bar
  BottomNavigationBar _buildBottomNavigationBar() {
    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.propane_outlined), label: "项目"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline), label: "体系"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit_outlined), label: "公众号"),
    ];

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: items,
        onTap: (index) => controller.onPageChange(index),
        currentIndex: controller.currentBottomIndex);
  }

  /// 生成左侧抽屉
  Widget _buildNavigationDrawer() {
    final titles = [
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text("首页"),
        onTap: () => Get.back(),
      ),
      const ListTile(leading: Icon(Icons.home), title: Text("首页")),
      const ListTile(leading: Icon(Icons.home), title: Text("首页")),
      const ListTile(leading: Icon(Icons.home), title: Text("首页")),
      const Divider(
        height: 50,
      ),
      const ListTile(leading: Icon(Icons.home), title: Text("首页")),
      const ListTile(leading: Icon(Icons.home), title: Text("首页")),
      const ListTile(leading: Icon(Icons.home), title: Text("首页")),
    ];

    final header = DrawerHeader(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              height: 80,
              child: CircleAvatar(
                child: Image.network(
                    "https://s3.o7planning.com/images/boy-128.png"),
              )),
          const SizedBox(height: 6),
          const Text("我是标题"),
          const SizedBox(height: 6),
          const Text("我是描述的内容"),
        ],
      ),
    );

    final items = <Widget>[];
    items.add(header);
    items.addAll(titles);
    // return NavigationDrawer(children: items);
    return Drawer(
      child: SafeArea(
        bottom: false,
        child: ListView(
          children: items,
        ),
      ),
    );
  }

  /// 与底部Bottom绑定的页面
  Widget _buildBody() {
    final pages = <Widget>[
      const KeepAliveWrapper(child: HomePage()),
      const KeepAliveWrapper(child: ProjectTabPage()),
      const KeepAliveWrapper(child: TreeTabPage()),
      const KeepAliveWrapper(child: PlatformTabPage()),
    ];

    return PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: pages,
    );
  }
}
