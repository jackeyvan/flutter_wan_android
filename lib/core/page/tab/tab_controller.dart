import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class GetTabController<T> extends GetxController
    with GetTickerProviderStateMixin, StateMixin<List<T>> {
  late TabController _tabController;
  late TabBar tabBar;
  late List<Widget> pages;

  @override
  Future<void> onReady() async {
    super.onReady();
    _tabController = TabController(vsync: this, length: 0);

    var tabs = await loadTabs() ?? [];

    if (tabs.isNotEmpty) {
      _tabController = TabController(vsync: this, length: tabs.length);

      value?.addAll(tabs);

      change(tabs, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  get tabController => _tabController;

  List<T> get tabs => value ?? [];

  Future<List<T>?> loadTabs();

  TabBar buildTabBar(List<T> tabs);

  List<Widget> buildPages(List<T> tabs);
}
