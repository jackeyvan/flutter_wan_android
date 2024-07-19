import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/banner_entity.dart';
import 'package:flutter_wan_android/app/modules/widget/article_item_widget.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_page.dart';

import 'home_controller.dart';

class HomePage extends GetRefreshPage<HomeController> {
  const HomePage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            title: Text("玩安卓",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            centerTitle: false,
            snap: true,
            pinned: true,
            floating: true,
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

  Widget buildBanner(List<BannerEntity> banner) => SizedBox(
        height: 240,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: CachedNetworkImage(
                  imageUrl: banner[index].imagePath ?? "",
                  fit: BoxFit.fill,
                ),
                onTap: () => Routes.toNamed(Routes.articleDetail,
                    args: ArticleEntity(
                        title: banner[index].title, link: banner[index].url)),
              );
            },
            itemCount: banner.length,
            pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(size: 8, activeSize: 8)),
            // control: const SwiperControl(),
          ),
        ),
      );
}
