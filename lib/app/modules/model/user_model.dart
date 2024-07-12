import 'dart:convert';

import 'package:flutter_wan_android/app/const/const_keys.dart';
import 'package:flutter_wan_android/core/storage/storage.dart';

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

    /// 解析User数据时，保存到本地
    Storage.write(ConstKeys.userKey, this);
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
}
