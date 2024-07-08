import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  final _currentBottomIndex = 0.obs;

  final pageController = PageController();

  set bottomIndex(index) {
    if (bottomIndex == index) {
      return;
    }

    _currentBottomIndex.value = index;
  }

  get bottomIndex => _currentBottomIndex.value;
}
