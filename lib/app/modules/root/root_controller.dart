import 'package:get/get.dart';

class RootController extends GetxController {
  final _currentBottomIndex = 0.obs;

  set bottomIndex(index) {
    _currentBottomIndex.value = index;
  }

  get bottomIndex => _currentBottomIndex.value;
}
