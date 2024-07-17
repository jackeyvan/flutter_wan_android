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
  /// 默认是登录页面
  final _isLoginPage = true.obs;

  final _provider = Get.find<LoginProvider>();

  bool get isLoginPage => _isLoginPage.value;

  final TextEditingController accountController =
      TextEditingController(text: "pgtwo");
  final TextEditingController passController =
      TextEditingController(text: "123456");

  final TextEditingController rePassController =
      TextEditingController(text: "123456");

  String get loginText => isLoginPage ? "登录" : "注册";

  /// 登录或者注册
  void toLogin() {
    final account = accountController.text;
    final password = passController.text;

    if (isNullOrBlank(account) || isNullOrBlank(password)) {
      Toast.showToast("账号或密码为空");
      return;
    }

    if (isLoginPage) {
      showLoadingDialog();

      _provider.login(true, account, password).then((user) {
        offPage("登录成功");
      }).catchError((error, stack) {
        handleError(error);
      });
    } else {
      final rePassword = rePassController.text;

      if (rePassword != password) {
        Toast.showToast("两次密码不一致");
        return;
      }
      showLoadingDialog();

      _provider
          .login(false, account, password, rePassword: rePassword)
          .then((user) {
        offPage("注册成功");
      }).catchError((error, stack) {
        handleError(error);
      });
    }
  }

  void handleError(error) {
    dismissLoadingDialog();
    Toast.showToast(error.toString());
  }

  void offPage(String text) {
    dismissLoadingDialog();
    Toast.showToast(text);
    Routes.offNamed(Routes.root);
  }

  changeToRegisterPage() {
    _isLoginPage.value = !isLoginPage;
    update();
  }
}
