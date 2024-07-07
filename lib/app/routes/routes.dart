import 'package:get/get.dart';

import '../modules/root/root_binding.dart';
import '../modules/root/root_page.dart';

abstract class _Paths {
  static const home = '/home';
  static const root = '/root';
}

class Routes {
  static const root = _Paths.root;

  static const splash = _Paths.home;

  static final routes = [
    GetPage(name: root, page: () => RootPage(), binding: RootBinding()),
  ];
}
