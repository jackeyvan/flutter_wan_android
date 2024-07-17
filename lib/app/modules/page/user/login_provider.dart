import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/model/user_model.dart';

abstract class Provider {
  Future<User> login(bool isLogin, String account, String password,
      {String? rePassword});
}

class LoginProvider extends Provider {
  @override
  Future<User> login(bool isLogin, String account, String password,
      {String? rePassword}) {
    if (isLogin) {
      return ApiProvider.to.post(ApiPaths.login, params: {
        "username": account,
        "password": password
      }).then((value) => User.fromJson(value));
    } else {
      return ApiProvider.to.post(ApiPaths.register, params: {
        "username": account,
        "password": password,
        "repassword": rePassword
      }).then((value) => User.fromJson(value));
    }
  }
}
