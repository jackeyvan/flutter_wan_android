import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ==============================
/// @author : mac
/// @time   : 2022/3/21 5:59 下午
/// @soft   : IntelliJ IDEA
/// @desc   : TODO
/// ================================

abstract class BasePage<T> extends GetView<T> {
  const BasePage({Key? key}) : super(key: key);
}
