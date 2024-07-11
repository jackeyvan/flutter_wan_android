import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/page/refresh/refresh.dart';
import '../model/article_model.dart';
import '../model/article_tab_model.dart';
import 'platform_provider.dart';

class PlatformTabController extends GetxController
    with GetTickerProviderStateMixin, StateMixin<List<ArticleTabModel>> {
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

  List<ArticleTabModel> get tabs => value ?? [];
}

class PlatformController extends GetRefreshListController<ArticleModel> {
  final _provider = PlatformProvider();

  final int? id;

  PlatformController({this.id});

  @override
  Future<List<ArticleModel>> loadData(int page) {
    return _provider.platformList(id ?? 0, page).then((e) => e.datas ?? []);
  }
}
