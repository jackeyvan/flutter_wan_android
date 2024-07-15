import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/page/base/base_controller.dart';
import 'package:get/get.dart';

abstract class GetTabController<T> extends BaseController<List<T>>
    with GetTickerProviderStateMixin {
  late TabController _tabController;

  String? _tabTitle;

  @override
  Future<void> onReady() async {
    super.onReady();
    _tabController = TabController(vsync: this, length: 0);

    loadTabs().then((tabs) {
      if (tabs.isNotEmpty) {
        _tabController = TabController(vsync: this, length: tabs.length);
        data = tabs;
        showSuccessPage();
      } else {
        showEmptyPage();
      }
    }).onError((error, stack) {
      showErrorPage(msg: error.toString());
    });
  }

  set title(String? title) => _tabTitle = title ?? "";

  String get title => _tabTitle ?? "";

  get tabController => _tabController;

  bool get isShowDrawer => false;

  List<T> get tabData => data ?? [];

  @override
  retryLoading() {
    showLoadingPage();
    onReady();
  }

  Future<List<T>> loadTabs();

  List<Widget> buildPages();

  List<Widget> buildTabs();
}
