import 'dart:convert';

import 'package:flutter_wan_android/app/modules/model/article_model.dart';
import 'package:flutter_wan_android/app/modules/model/article_tab_model.dart';

///  知识体系和导航的model不一样，需要封装一下
class TreeModel {
  String? name;
  String? link;
  int? id;

  bool fromTree = false;

  List<TreeModel>? items;

  TreeModel({
    this.name,
    this.items,
    this.link,
    this.id,
  });

  ///体系数据
  TreeModel.transFromTree(ArticleTabModel model) {
    name = model.name;
    items =
        model.children?.map((e) => TreeModel(name: e.name, id: e.id)).toList();
    fromTree = true;
  }

  ///导航数据
  TreeModel.transFromNavi(NaviTabModel model) {
    name = model.name;
    items = model.articles
        ?.map((e) => TreeModel(name: e.title, link: e.link))
        .toList();
    fromTree = false;
  }
}

NaviTabModel fromJson(String str) => NaviTabModel.fromJson(json.decode(str));

String toJson(NaviTabModel data) => json.encode(data.toJson());

class NaviTabModel {
  NaviTabModel({
    this.articles,
    this.cid,
    this.name,
  });

  NaviTabModel.fromJson(dynamic json) {
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(ArticleModel.fromJson(v));
      });
    }
    cid = json['cid'];
    name = json['name'];
  }

  List<ArticleModel>? articles;
  int? cid;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (articles != null) {
      map['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    map['cid'] = cid;
    map['name'] = name;
    return map;
  }
}
