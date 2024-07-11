import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/page/refresh/refresh.dart';
import '../model/article_model.dart';
import 'home_controller.dart';

class HomePage extends GetRefreshListPage<HomeController> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return buildObx(
        builder: () => buildRefreshListView<ArticleModel>(
            shrinkWrap: true,
            itemBuilder: (item, index) {
              var banner = item.banner;

              if (banner != null && banner.isNotEmpty) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  height: 240,
                  child: Card(
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: CachedNetworkImage(
                            imageUrl: banner[index].imagePath ?? "",
                            fit: BoxFit.fill,
                          ),
                          onTap: () {
                            /// TODO
                          },
                        );
                      },
                      itemCount: banner.length,
                      pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              size: 8, activeSize: 8)),
                      // control: const SwiperControl(),
                    ),
                  ),
                );
              }

              return Container(
                /// 设置左上右下的边距，顶部的边距需要Listview自己设置
                margin: const EdgeInsets.fromLTRB(6, 0, 6, 6),
                child: Card(
                  /// 卡片的圆角，和水波纹匹配
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: InkWell(
                    /// 点击水波纹的圆角
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: ListTile(
                        title: Text(
                          "${item.title}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        subtitle: Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "${item.chapterName}",
                              maxLines: 5,
                            ))),
                    onTap: () {
                      print("---------->点击了 = $index item:$item");
                    },
                  ),
                ),
              );
            }));
  }
}
