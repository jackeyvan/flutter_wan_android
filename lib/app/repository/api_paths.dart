class ApiPaths {
  /// 基础url
  static const baseUrl = "https://www.wanandroid.com/";

  /// 文章列表
  static const String articleList = "article/list/";

  /// 置顶文章
  static const String topArticle = "article/top/json";

  /// 获取banner
  static const String banner = "banner/json";

  /// 登录
  static const String login = "user/login";

  /// 注册
  static const String register = "user/register";

  /// 退出登录
  static const String logout = "user/logout/json";

  /// 项目分类
  static const String projectCategory = "project/tree/json";

  /// 项目列表
  static const String projectList = "project/list/";

  /// 搜索
  static const String searchForKeyword = "article/query/";

  /// 广场页列表
  static const String plazaArticleList = "user_article/list/";

  /// 点击收藏
  static const String collectArticle = "lg/collect/";

  /// 取消收藏
  static const String unCollectArticle = "lg/uncollect_originId/";

  /// 获取搜索热词
  static const String hotKeywords = "hotkey/json";

  /// 获取收藏文章列表
  static const String collectList = "lg/collect/list/";

  /// 收藏网站列表
  static const String collectWebaddressList = "lg/collect/usertools/json";

  /// 我的分享
  static const String sharedList = "user/lg/private_articles/";

  /// 分享文章 post
  static const String shareArticle = "lg/user_article/add/json";

  /// todoList
  static const String todoList = "lg/todo/v2/list/";

  /// 公众号
  static const String wxArticleTab = "wxarticle/chapters/json";

  /// 某个公众号的文章列表  wxarticle/list/408/1/json
  static const String wxArticleList = "wxarticle/list/";

  /// 学习体系
  static const String treeList = "tree/json";

  /// 导航  navi/json
  static const String naviList = "navi/json";

  /// 用户信息
  static const String userinfo = "user/lg/userinfo/json";
}
