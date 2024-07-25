import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/entity/hot_key_entity.dart';
import 'package:flutter_wan_android/app/modules/pages/home/home_controller.dart';

import 'search_result_page.dart';
import 'search_suggestions_page.dart';

/// 搜索
class SearchBarDelegate extends SearchDelegate<HotKeyEntity> {
  final HomeController controller;

  SearchBarDelegate({required this.controller, String? hintText})
      : super(searchFieldLabel: hintText);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isNotEmpty) {
              query = '';
              showSuggestions(context);
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isNotEmpty
        ? SearchResultPage(query)
        : buildSuggestions(context);
  }

  /// 输入框值发生变化就会调用，所以这个方法不能加载数据，需要提前加载好然后构建
  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchSuggestionsPage(controller, this);
  }

  @override
  void dispose() {
    print("---------> dispose");
    super.dispose();
  }
}
