import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/page/base/base_page.dart';

import 'search_controller.dart';

class SearchPage extends BasePage<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("标题"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SearchAnchor(builder: (context, controller) {
          return SearchBar(
            leading: const BackButton(),
            elevation: WidgetStateProperty.all(0),
            controller: controller,
            hintText: "搜索",
            onTap: () => controller.openView,
            onChanged: (value) {},
          );
        }, suggestionsBuilder: (context, controller) {
          return [
            const ListTile(
              title: Text("数据1"),
            ),
            const ListTile(
              title: Text("数据2"),
            ),
            const ListTile(
              title: Text("数据3"),
            ),
          ];
        }),
      ),
    );
  }
}
