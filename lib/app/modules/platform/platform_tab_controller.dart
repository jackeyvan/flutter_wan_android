import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/platform_tab_model.dart';
import 'provider/platform_provider.dart';

class PlatformTabController extends GetxController
    with GetTickerProviderStateMixin, StateMixin<List<PlatformTabModel>> {
  final _provider = PlatformProvider();

  late TabController _tabController;

  @override
  Future<void> onReady() async {
    super.onReady();
    _tabController = TabController(vsync: this, length: 0);

    var tabs = await _provider.platformTab();

    _tabController = TabController(vsync: this, length: tabs.length);

    value = tabs;

    change(value, status: RxStatus.success());
  }

  get tabController => _tabController;

  List<PlatformTabModel> get tabs => value ?? [];
}
