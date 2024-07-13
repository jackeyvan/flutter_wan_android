import 'package:flutter_wan_android/core/page/refresh/refresh_controller.dart';
import 'package:get/get.dart';

import '../../model/theme_model.dart';

class ThemeController extends GetRefreshListController {
  static ThemeController get i => Get.find();

  final theme = 'System'.obs;

  ThemeModel get themeModel =>
      ThemeModel.themes.firstWhere((element) => element.name == theme.value,
          orElse: () => ThemeModel.themes.first);

  @override
  Future<List<ThemeModel>> loadListData(int page, bool isRefresh) {
    return Future.value(ThemeModel.themes);
  }
}
