import 'package:flutter/material.dart';
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
        drawer: _buildNavigationDrawer(),
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

  /// 生成左侧抽屉
  Widget _buildNavigationDrawer() {
    final titles = [
      ListTile(
        leading: const Icon(Icons.login),
        title: const Text("登录"),
        onTap: () => Routes.toNamed(Routes.login),
      ),
      ListTile(
          leading: const Icon(Icons.home),
          title: const Text("主题"),
          onTap: () => Routes.toNamed(Routes.themeChose)),
      ListTile(
          leading: const Icon(Icons.home),
          title: const Text("语言"),
          onTap: () => Routes.toNamed(Routes.language)),
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
}
