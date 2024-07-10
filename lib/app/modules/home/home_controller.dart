import 'package:flutter_wan_android/app/modules/home/model/home_article_model.dart';
import 'package:flutter_wan_android/app/modules/home/model/top_article_model.dart';

import '../../../core/refresh/refresh_list_controller.dart';
import 'model/banner_model.dart';
import 'provider/home_provider.dart';

class HomeController extends GetRefreshListController<HomeArticleModel> {
  final _provider = HomeProvider();

  HomeController() : super();

  @override
  Future<List<HomeArticleModel>> loadData(int page) {
    return Future.wait([
      _provider.banner(),
      _provider.topArticle(),
      _provider.homePageArticle(page)
    ]).then((result) {
      var data = <HomeArticleModel>[];

      data.add(HomeArticleModel(banner: result[0] as List<BannerModel>));
      data.add(
          HomeArticleModel(topArticle: result[1] as List<TopArticleModel>));

      var listModel = (result[2] as HomeArticleListModel).datas;

      if (listModel != null) {
        data.addAll(listModel);
      }

      return data;
    });
  }
}
