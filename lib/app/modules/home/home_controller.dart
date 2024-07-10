import '../../../core/page/refresh/refresh.dart';
import 'model/banner_model.dart';
import 'model/home_article_model.dart';
import 'provider/home_provider.dart';

class HomeController extends GetRefreshListController<HomeArticleModel> {
  final _provider = HomeProvider();

  @override
  Future<List<HomeArticleModel>> loadData(int page) {
    return Future.wait([
      _provider.banner(),
      _provider.topArticle(),
      _provider.homePageArticle(page)
    ]).then((result) {
      var data = <HomeArticleModel>[];

      /// 第一条数据为banner
      var banner = result[0] as List<BannerModel>?;

      if (banner != null && banner.isNotEmpty) {
        data.add(HomeArticleModel(banner: banner));
      }

      var topArticle = result[1] as List<HomeArticleModel>?;

      if (topArticle != null) {
        data.addAll(topArticle);
      }

      var listModel = (result[2] as HomeArticleListModel).datas;

      if (listModel != null) {
        data.addAll(listModel);
      }

      return data;
    });
  }
}
