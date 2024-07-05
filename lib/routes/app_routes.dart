import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';

abstract class _Paths {
  static const home = '/home';
}

class Routes {
  // static const INITIAL = _Paths.INITIAL;
  static const splash = _Paths.home;

  static final routes = [
    // GetPage(
    //   name: INITIAL,
    //   page: () => UserPage(),
    // ),

    GetPage(name: splash, page: () => HomePage(), binding: HomeBinding()),

    // 交易所设置页面
    // GetPage(
    //     name: EXCAHNGE_PROFILE,
    //     page: () => const ExchangeProfilePage(),
    //     binding: ExchangeProfileBinding(),
    //     children: [
    //       GetPage(
    //           name: _Paths.EXCAHNGE_EDIT,
    //           page: () => const ExchangeEditPage(),
    //           binding: ExchangeEditBinding()),
    //     ]),
    //
    // // 量化策略页面
    // GetPage(name: QUANT_HOME, page: () => const QuantHomePage()),
    // GetPage(
    //     name: SYMBOL, page: () => const SymbolPage(), binding: SymbolBinding()),
    // GetPage(
    //     name: PORTFOLIO,
    //     page: () => const PortfolioPage(),
    //     binding: PortfolioBinding()),
    //
    // GetPage(name: WALLET, page: () => WalletPage(), binding: WalletBinding()),
  ];
}
