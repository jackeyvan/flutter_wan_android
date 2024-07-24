import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/const/styles.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/banner_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/hot_key_entity.dart';
import 'package:flutter_wan_android/app/modules/widget/article_item_widget.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_page.dart';
import 'package:flutter_wan_android/core/page/status/default_empty_page.dart';
import 'package:flutter_wan_android/core/page/status/default_error_page.dart';
import 'package:flutter_wan_android/core/page/status/default_loading_page.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetRefreshPage<HomeController> {
  const HomePage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: Text(Strings.label.tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            centerTitle: false,
            snap: true,
            pinned: true,
            floating: true,
            actions: [
              IconButton(
                  onPressed: () => showSearch(
                      context: context,
                      delegate: SearchBarDelegate(
                          controller: controller, hintText: "搜索")),
                  icon: const Icon(Icons.search))
            ],
          ),
        ];
      },
      body: buildObxRefreshListPage<ArticleEntity>(
        padding: const EdgeInsets.all(6),
        separatorBuilder: (item, index) => const SizedBox(height: 3),
        itemBuilder: (item, index) {
          var banner = item.banner;

          if (banner != null && banner.isNotEmpty) {
            return buildBanner(banner);
          }

          return ArticleItemWidget(item);
        },
      ),
    );
  }

  Widget buildBanner(List<BannerEntity> banner) {
    return CarouselSlider.builder(
        options: CarouselOptions(
          height: 240,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
        ),
        itemCount: banner.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: InkWell(
                  onTap: () => Routes.toNamed(Routes.articleDetail,
                      args: ArticleEntity(
                          title: banner[itemIndex].title,
                          link: banner[itemIndex].url)),
                  child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: banner[itemIndex].imagePath ?? "")),
            ),
          );
        });
  }
}

/// 搜索
class SearchBarDelegate extends SearchDelegate<HotKeyEntity> {
  final HomeController controller;

  SearchBarDelegate({required this.controller, String? hintText})
      : super(searchFieldLabel: hintText);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(children: [
      const ListTile(title: Text("buildResults1")),
      const ListTile(title: Text("buildResults2")),
      const ListTile(title: Text("buildResults3")),
    ]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<HotKeyEntity>>(
        future: controller.hotKeywords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else if (snapshot.hasError) {
            return ErrorPage(msg: snapshot.error?.toString());
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.separated(
                padding: const EdgeInsets.all(12),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    final hotkeys = data?.where((e) => !e.isHistory).toList();

                    return hotkeys != null && hotkeys.isNotEmpty
                        ? buildSuggestionsItem(true, hotkeys)
                        : const SizedBox.shrink();
                  } else {
                    final history = data?.where((e) => e.isHistory).toList();

                    return history != null && history.isNotEmpty
                        ? buildSuggestionsItem(false, history)
                        : const SizedBox.shrink();
                  }
                },
                itemCount: 2);
          } else {
            return const EmptyPage();
          }
        });
  }

  Widget buildSuggestionsItem(bool isHotkey, List<HotKeyEntity> data) {
    return Column(children: [
      Row(children: [
        Text(isHotkey ? "热门搜索" : "历史搜索", style: const TextStyle(fontSize: 16)),
        const Spacer(),
        TextButton.icon(
          onPressed: () {},
          label: Text(isHotkey ? "换一换" : "清空"),
          icon: Icon(isHotkey ? Icons.refresh : Icons.clear),
        )
      ]),
      Wrap(
        spacing: 8,
        runSpacing: 4,
        children: data
            .map((e) =>
                OutlinedButton(onPressed: () {}, child: Text(e.name ?? "")))
            .toList(),
      )
    ]);
  }
}
