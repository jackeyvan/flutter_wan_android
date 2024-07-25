import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/const/keys.dart';
import 'package:flutter_wan_android/app/modules/entity/hot_key_entity.dart';
import 'package:flutter_wan_android/app/modules/pages/home/home_controller.dart';
import 'package:flutter_wan_android/core/init/storage.dart';
import 'package:flutter_wan_android/core/page/status/default_empty_page.dart';
import 'package:flutter_wan_android/core/page/status/default_error_page.dart';
import 'package:flutter_wan_android/core/page/status/default_loading_page.dart';
import 'package:flutter_wan_android/core/utils/overlay_utils.dart';

import 'search_delegate_page.dart';

class SearchSuggestionsPage extends StatelessWidget {
  final HomeController controller;
  final SearchBarDelegate delegate;

  const SearchSuggestionsPage(this.controller, this.delegate, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [buildHotkeyItem(context), buildHistoryItem(context)],
            ),
          ),
        ),
      );
    });
  }

  Widget buildHotkeyItem(BuildContext context) {
    return FutureBuilder<List<HotKeyEntity>>(
        future: controller.hotKeywords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else if (snapshot.hasError) {
            return ErrorPage(msg: snapshot.error?.toString());
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            return data != null
                ? buildSuggestionsItem(
                    context, true, data.map((e) => e.name ?? "").toList())
                : const SizedBox.shrink();
          } else {
            return const EmptyPage();
          }
        });
  }

  buildHistoryItem(BuildContext context) {
    final data = controller.searchHistory();
    return data.isNotEmpty
        ? buildSuggestionsItem(context, false, data)
        : const SizedBox.shrink();
  }

  Widget buildSuggestionsItem(
      BuildContext context, bool isHotkey, List<String> data) {
    return Column(children: [
      Row(children: [
        Text(isHotkey ? "热门搜索" : "历史搜索", style: const TextStyle(fontSize: 16)),
        const Spacer(),
        TextButton.icon(
          onPressed: () => controller.hotKeywords(),
          label: Text(isHotkey ? "换一换" : "清空"),
          icon: Icon(isHotkey ? Icons.refresh : Icons.clear),
        )
      ]),
      Wrap(
        spacing: 10,
        runSpacing: 2,
        children: data
            .map((e) => OutlinedButton(
                onPressed: () {
                  if (isHotkey) {
                    delegate.query = e;
                    delegate.showResults(context);
                  } else {
                    Storage.remove(Keys.searchHistory);
                    OverlayUtils.showToast("清除成功");
                  }
                },
                child: Text(e)))
            .toList(),
      )
    ]);
  }
}
