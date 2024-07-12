import 'package:flutter/material.dart';

/// 可以设置高度的TabBar
class FixTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final TabController controller;

  final String? title;

  const FixTabBar(
      {super.key, this.title, required this.tabs, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: AppBar(
        title: _showTitle() ? Text("$title") : const SizedBox.shrink(),
        bottom: TabBar(
          labelStyle: const TextStyle(fontSize: 15),
          indicatorSize: TabBarIndicatorSize.label,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: tabs,
          controller: controller,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_showTitle() ? 56 + 48 : 48);

  bool _showTitle() => !(title == null || title == "");
}
