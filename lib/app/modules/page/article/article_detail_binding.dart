import 'package:flutter_wan_android/app/modules/page/article/article_detail_controller.dart';
import 'package:get/get.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticleDetailController());
  }
}
