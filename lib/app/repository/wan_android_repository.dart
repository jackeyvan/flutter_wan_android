import 'package:flutter_wan_android/app/modules/entity/article_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/article_tab_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/banner_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/structure_entity.dart';
import 'package:flutter_wan_android/app/modules/entity/user_entity.dart';
import 'package:flutter_wan_android/app/repository/api_paths.dart';
import 'package:flutter_wan_android/app/repository/api_provider.dart';
import 'package:flutter_wan_android/core/net/cache_Interceptor.dart';

/// 接口仓库，提供玩安卓所有接口
class WanAndroidRepository {
  /// Banner数据
  static Future<List<BannerEntity>> banner() =>
      ApiProvider.to.get<List<BannerEntity>>(ApiPaths.banner);

  /// 首页文章
  static Future<ArticleListEntity> homePageArticle(int page) => ApiProvider.to
      .get<ArticleListEntity>("${ApiPaths.articleList}$page/json");

  ///  置顶文章
  static Future<List<ArticleEntity>> topArticle() =>
      ApiProvider.to.get<List<ArticleEntity>>(ApiPaths.topArticle);

  static Future<ArticleListEntity> platformList(int id, int page) =>
      ApiProvider.to
          .get<ArticleListEntity>("${ApiPaths.wxArticleList}$id/$page/json");

  static Future<List<ArticleTabEntity>> platformTab() =>
      ApiProvider.to.get<List<ArticleTabEntity>>(ApiPaths.wxArticleTab);

  static Future<List<ArticleTabEntity>> projectTabs() =>
      ApiProvider.to.get<List<ArticleTabEntity>>(ApiPaths.projectCategory);

  static Future<ArticleListEntity> projectList(int id, int page) =>
      ApiProvider.to.get<ArticleListEntity>("${ApiPaths.projectList}$page/json",
          params: {"cid": id});

  /// 导航系列数据
  static Future<List<StructureEntity>> naviTabs() => ApiProvider.to
      .get<List<NavigateEntity>>(ApiPaths.naviList)
      .then((entities) =>
          entities.map((e) => StructureEntity.transFromNavi(e)).toList());

  /// 学习体系系列数据
  static Future<List<StructureEntity>> treeTabs() => ApiProvider.to
      .get<List<ArticleTabEntity>>(ApiPaths.treeList)
      .then((entities) =>
          entities.map((e) => StructureEntity.transFromTree(e)).toList());

  static Future<ArticleListEntity> treeList(int page, int id) =>
      ApiProvider.to.get<ArticleListEntity>("${ApiPaths.articleList}$page/json",
          params: {"cid": id});

  static Future<User> login(bool isLogin, String account, String password,
      {String? rePassword}) {
    if (isLogin) {
      return ApiProvider.to.post<User>(ApiPaths.login,
          cacheMode: CacheMode.remoteOnly,
          params: {"username": account, "password": password});
    } else {
      return ApiProvider.to.post<User>(ApiPaths.register,
          cacheMode: CacheMode.remoteOnly,
          params: {
            "username": account,
            "password": password,
            "repassword": rePassword
          });
    }
  }
}
