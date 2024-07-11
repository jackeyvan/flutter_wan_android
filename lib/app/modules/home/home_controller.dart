import '../../../core/page/refresh/refresh.dart';
import '../model/article_model.dart';
import '../model/banner_model.dart';
import 'home_provider.dart';

class HomeController extends GetRefreshListController<ArticleModel> {
  final _provider = HomeProvider();

  @override
  Future<List<ArticleModel>> loadData(int page) {
    return Future.wait([
      _provider.banner(),
      _provider.topArticle(),
      _provider.homePageArticle(page)
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
  }
}
