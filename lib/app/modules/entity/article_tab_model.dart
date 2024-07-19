import 'dart:convert';

ArticleTabModel fromJson(String str) =>
    ArticleTabModel.fromJson(json.decode(str));

String toJson(ArticleTabModel data) => json.encode(data.toJson());

class ArticleTabModel {
  ArticleTabModel({
    this.articleList,
    this.author,
    this.children,
    this.courseId,
    this.cover,
    this.desc,
    this.id,
    this.lisense,
    this.lisenseLink,
    this.name,
    this.order,
    this.parentChapterId,
    this.type,
    this.userControlSetTop,
    this.visible,
  });

  ArticleTabModel.fromJson(dynamic json) {
    if (json['articleList'] != null) {
      articleList = [];
      json['articleList'].forEach((v) {
        // articleList?.add(Dynamic.fromJson(v));
      });
    }
    author = json['author'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(ArticleTabModel.fromJson(v));
      });
    }
    courseId = json['courseId'];
    cover = json['cover'];
    desc = json['desc'];
    id = json['id'];
    lisense = json['lisense'];
    lisenseLink = json['lisenseLink'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    type = json['type'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
  }

  List<dynamic>? articleList;
  String? author;
  List<ArticleTabModel>? children;
  int? courseId;
  String? cover;
  String? desc;
  int? id;
  String? lisense;
  String? lisenseLink;
  String? name;
  int? order;
  int? parentChapterId;
  int? type;
  bool? userControlSetTop;
  int? visible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (articleList != null) {
      map['articleList'] = articleList?.map((v) => v.toJson()).toList();
    }
    map['author'] = author;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    map['courseId'] = courseId;
    map['cover'] = cover;
    map['desc'] = desc;
    map['id'] = id;
    map['lisense'] = lisense;
    map['lisenseLink'] = lisenseLink;
    map['name'] = name;
    map['order'] = order;
    map['parentChapterId'] = parentChapterId;
    map['type'] = type;
    map['userControlSetTop'] = userControlSetTop;
    map['visible'] = visible;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
