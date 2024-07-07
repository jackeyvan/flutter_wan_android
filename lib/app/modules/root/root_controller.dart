import 'package:get/get.dart';

import '../../routes/routes.dart';

class RootController extends GetxController {
  final _currentBottomIndex = 0.obs;

  final _pagePaths = [
    Routes.home,
    Routes.project,
    Routes.series,
    Routes.platform,
  ];

  set bottomIndex(index) {
    if (bottomIndex == index) {
      return;
    }

    _currentBottomIndex.value = index;

    // Routes.to(_pagePaths[index], id: 1);
    // Get.offNamedUntil(
    //     _pagePaths[index], (page) => page.settings.name == Routes.home,
    //     id: 1);
  }

  get bottomIndex => _currentBottomIndex.value;
}
