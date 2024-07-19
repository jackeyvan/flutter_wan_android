import 'dart:convert';

import 'package:flutter_wan_android/generated/json/article_entity.g.dart';
import 'package:flutter_wan_android/generated/json/base/json_field.dart';

export 'package:flutter_wan_android/generated/json/article_entity.g.dart';

@JsonSerializable()
class ArticleEntity {
  int? curPage;
  List<ArticleDatas>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  ArticleEntity();

  factory ArticleEntity.fromJson(Map<String, dynamic> json) =>
      $ArticleEntityFromJson(json);

  Map<String, dynamic> toJson() => $ArticleEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ArticleDatas {
  bool? adminAdd;
  String? apkLink;
  int? audit;
  String? author;
  bool? canEdit;
  int? chapterId;
  String? chapterName;
  bool? collect;
  int? courseId;
  String? desc;
  String? descMd;
  String? envelopePic;
  bool? fresh;
  String? host;
  int? id;
  bool? isAdminAdd;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String? shareUser;
  int? superChapterId;
  String? superChapterName;
  List<ArticleDatasTags>? tags;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;

  ArticleDatas();

  factory ArticleDatas.fromJson(Map<String, dynamic> json) =>
      $ArticleDatasFromJson(json);

  Map<String, dynamic> toJson() => $ArticleDatasToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ArticleDatasTags {
  String? name;
  String? url;

  ArticleDatasTags();

  factory ArticleDatasTags.fromJson(Map<String, dynamic> json) =>
      $ArticleDatasTagsFromJson(json);

  Map<String, dynamic> toJson() => $ArticleDatasTagsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
