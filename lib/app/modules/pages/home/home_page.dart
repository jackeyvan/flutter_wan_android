import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/const/styles.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/banner_entity.dart';
import 'package:flutter_wan_android/app/modules/widget/article_item_widget.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_page.dart';
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
                  onPressed: () => Routes.toNamed(Routes.search),
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
                      imageUrl: banner[itemIndex].url ?? "")),
            ),
          );
        });
  }
}
