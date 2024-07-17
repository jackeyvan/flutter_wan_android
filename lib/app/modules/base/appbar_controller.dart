import 'package:flutter/material.dart';
import 'package:flutter_wan_android/core/page/base/base_controller.dart';
import 'package:get/get.dart';

abstract class AppbarController<T> extends BaseController<List<T>>
    with GetTickerProviderStateMixin {
  TabController? _tabController;

  String? _title;

  @override
  void onReady() {
    super.onReady();

    if (isShowTab) {
      _tabController = TabController(vsync: this, length: 0);

      loadTabs()?.then((tabs) {
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
    } else {
      showSuccessPage();
    }
  }

  String? get title => _title;

  set title(String? title) => _title = title;

  TabController? get tabController => _tabController;

  bool get isShowTab => false;

  List<T> get tabData => data ?? [];

  @override
  retryLoading() {
    showLoadingPage();
    onReady();
  }

  Future<List<T>>? loadTabs() => null;

  List<Widget> buildTabPages() => [];

  List<Widget> buildTabs() => [];
}
