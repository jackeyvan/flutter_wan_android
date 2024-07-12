import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/banner_model.dart';
import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';
import 'package:get/get.dart';

import 'home_provider.dart';

class HomeController extends GetRefreshListController<ArticleModel> {
  @override
  Future<List<ArticleModel>> loadData(int page, bool isRefresh) {
    final provider = Get.find<HomeProvider>();

    if (isRefresh) {
      return Future.wait([
        provider.banner(),
        provider.topArticle(),
        provider.homePageArticle(page)
      ]).then((result) {
        var data = <ArticleModel>[];

        /// 第一条数据为banner
        var banner = result[0] as List<BannerModel>?;

        if (banner != null && banner.isNotEmpty) {
          data.add(ArticleModel(banner: banner));
        }

        var topArticle = result[1] as List<ArticleModel>?;

        if (topArticle != null) {
          data.addAll(topArticle);
        }

        var listModel = (result[2] as ArticleListModel).datas;

        if (listModel != null) {
          data.addAll(listModel);
        }

        return data;
      });
    } else {
      return provider.homePageArticle(page).then((e) => Future.value(e.datas));
    }
  }
}
