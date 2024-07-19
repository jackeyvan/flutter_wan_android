import 'package:flutter_wan_android/app/api/api_paths.dart';
import 'package:flutter_wan_android/app/api/api_provider.dart';
import 'package:flutter_wan_android/app/modules/entity/user_entity.dart';
import 'package:flutter_wan_android/core/net/cache_Interceptor.dart';

abstract class Provider {
  /// 登录和注册接口没有缓存
  Future<User> login(bool isLogin, String account, String password,
      {String? rePassword});
}

class LoginProvider extends Provider {
  @override
  Future<User> login(bool isLogin, String account, String password,
      {String? rePassword}) {
    if (isLogin) {
      return ApiProvider.to.post<User>(ApiPaths.login,
          cacheMode: CacheMode.remoteOnly,
          params: {"username": account, "password": password});
    } else {
      return ApiProvider.to.post<User>(ApiPaths.register,
          cacheMode: CacheMode.remoteOnly,
          params: {
            "username": account,
            "password": password,
            "repassword": rePassword
          });
    }
  }
}
