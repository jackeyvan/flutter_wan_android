import 'dart:convert';

import 'package:flutter_wan_android/app/const/keys.dart';
import 'package:flutter_wan_android/core/init/storage.dart';

User fromJson(String str) => User.fromJson(json.decode(str));

String toJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.admin,
    this.chapterTops,
    this.coinCount,
    this.collectIds,
    this.email,
    this.icon,
    this.id,
    this.nickname,
    this.password,
    this.publicName,
    this.token,
    this.type,
    this.username,
  });

  static User? _user;

  /// 获取用户信息
  static User? getUser() {
    final value = Storage.read(Keys.userKey);
    if (value != null) {
      _user ??= User.fromJson(value);
    }

    return _user;
  }

  /// 根据本地信息判断用户是否登录
  static bool isLogin() {
    return getUser() != null;
  }

  /// 清除用户信息
  static Future<void> clear() {
    _user = null;
    return Storage.remove(Keys.userKey);
  }

  User.fromJson(dynamic json) {
    admin = json['admin'];
    if (json['chapterTops'] != null) {
      chapterTops = [];
      json['chapterTops'].forEach((v) {
        // chapterTops?.add(Dynamic.fromJson(v));
      });
    }
    coinCount = json['coinCount'];
    if (json['collectIds'] != null) {
      collectIds = [];
      json['collectIds'].forEach((v) {
        // collectIds?.add(Dynamic.fromJson(v));
      });
    }
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];

    if (json != null) {
      _user = this;

      /// 解析User数据时，保存到本地
      Storage.write(Keys.userKey, _user);
    }
  }

  bool? admin;
  List<dynamic>? chapterTops;
  int? coinCount;
  List<dynamic>? collectIds;
  String? email;
  String? icon;
  int? id;
  String? nickname;
  String? password;
  String? publicName;
  String? token;
  int? type;
  String? username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['admin'] = admin;
    if (chapterTops != null) {
      map['chapterTops'] = chapterTops?.map((v) => v.toJson()).toList();
    }
    map['coinCount'] = coinCount;
    if (collectIds != null) {
      map['collectIds'] = collectIds?.map((v) => v.toJson()).toList();
    }
    map['email'] = email;
    map['icon'] = icon;
    map['id'] = id;
    map['nickname'] = nickname;
    map['password'] = password;
    map['publicName'] = publicName;
    map['token'] = token;
    map['type'] = type;
    map['username'] = username;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
