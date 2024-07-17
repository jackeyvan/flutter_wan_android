import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/modules/page/user/login_provider.dart';
import 'package:flutter_wan_android/app/routes/routes.dart';
import 'package:flutter_wan_android/core/init/init_core.dart';
import 'package:flutter_wan_android/core/init/toast.dart';
import 'package:flutter_wan_android/core/page/base/base_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginProvider());
    Get.lazyPut(() => LoginController());
  }
}

class LoginController extends BaseController {
  final _provider = Get.find<LoginProvider>();

  final TextEditingController accountController =
      TextEditingController(text: "pgtwo");
  final TextEditingController passController =
      TextEditingController(text: "123456");

  toLogin() {
    final account = accountController.text;
    final password = passController.text;

    if (isNullOrBlank(account) || isNullOrBlank(password)) {
      Toast.showToast("账号或密码为空");
      return;
    }

    showLoadingDialog();

    _provider.login(true, account, password).then((user) {
      dismissLoadingDialog();
      Routes.offNamed(Routes.root);
    }).catchError((error, stack) {
      dismissLoadingDialog();
      Toast.showToast(error.toString());
    });
  }
}
