import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';
import 'package:flutter_wan_android/core/page/refresh/list/refresh_list_controller.dart';
import 'package:get/get.dart';

import 'platform_provider.dart';

class PlatformTabController extends GetxController
    with GetTickerProviderStateMixin, StateMixin<List<ArticleTabModel>> {
  final _provider = PlatformProvider();

  late TabController _tabController;

  @override
  Future<void> onReady() async {
    _tabController = TabController(vsync: this, length: 0);

    _provider.platformTab().then((tabs) {
      _tabController = TabController(vsync: this, length: tabs.length);

      change(tabs, status: RxStatus.success());
    }).onError((err, stack) {
      change(null, status: RxStatus.error(err.toString()));
    });
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
