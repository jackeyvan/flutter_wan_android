import 'package:flutter_wan_android/app/api/wan_android_repository.dart';
import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/banner_entity.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';

class HomeController extends GetRefreshListController<ArticleEntity> {
  @override
  Future<List<ArticleEntity>> loadListData(int page, bool isRefresh) {
    if (isRefresh) {
      return Future.wait([
        WanAndroidRepository.banner(),
        WanAndroidRepository.topArticle(),
        WanAndroidRepository.homePageArticle(page)
      ]).then((result) {
        var data = <ArticleEntity>[];

        /// 第一条数据为banner
        final banner = result[0] as List<BannerEntity>?;

        if (banner != null && banner.isNotEmpty) {
          data.add(ArticleEntity(banner: banner));
        }

        var topArticle = result[1] as List<ArticleEntity>?;

        if (topArticle != null) {
          data.addAll(topArticle);
        }

        var listModel = (result[2] as ArticleListEntity).datas;

        if (listModel != null) {
          data.addAll(listModel);
        }

        return data;
      });
    } else {
      return WanAndroidRepository.homePageArticle(page)
          .then((e) => Future.value(e.datas));
    }
  }
}
