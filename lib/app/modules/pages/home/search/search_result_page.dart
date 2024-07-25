import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/api/wan_android_repository.dart';
import 'package:flutter_wan_android/app/const/keys.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/widget/article_item_widget.dart';
import 'package:flutter_wan_android/core/init/storage.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_page.dart';
import 'package:get/get.dart';

class SearchResultPage extends GetRefreshPage<SearchResultController> {
  final String query;

  const SearchResultPage(this.query, {super.key});

  @override
  String? get tag => query;

  @override
  void dependencies() {
    Get.lazyPut(() => SearchResultController(query), tag: query);
    final history = Storage.read<List<String>>(Keys.searchHistory) ?? [];
    if (history.contains(query)) return;
    history.insert(0, query);
    Storage.write(Keys.searchHistory, history);
  }

  @override
  Widget buildPage(BuildContext context) {
    return buildObxRefreshListPage<ArticleEntity>(
        itemBuilder: (data, index) => ArticleItemWidget(data));
  }
}

class SearchResultController extends GetRefreshListController<ArticleEntity> {
  final String query;

  SearchResultController(this.query);

  @override
  void onReady() {
    print("------> onReady");
    super.onReady();
  }

  @override
  void onClose() {
    print("------> onClose");
    super.onClose();
  }

  @override
  Future<List<ArticleEntity>> loadListData(int page, bool isRefresh) {
    print("------> loadListData ${query}");
    return WanAndroidRepository.fetchSearchResult(query, page);
  }
}
