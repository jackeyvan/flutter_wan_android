import 'dart:convert';

class BannerModel {
  final String? desc;
  final String? imagePath;
  final String? title;
  final String? url;
  final int? id;
  final int? isVisible;
  final int? order;
  final int? type;

  const BannerModel(
      {required this.desc,
      required this.imagePath,
      required this.title,
      required this.url,
      required this.id,
      required this.isVisible,
      required this.order,
      required this.type});

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory BannerModel.fromJson(dynamic json) => BannerModel(
      desc: json['desc'],
      imagePath: json['imagePath'],
      title: json['title'],
      url: json['url'],
      id: json['id'],
      isVisible: json['isVisible'],
      order: json['order'],
      type: json['type']);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['desc'] = desc;
    json['imagePath'] = imagePath;
    json['title'] = title;
    json['url'] = url;
    json['id'] = id;
    json['isVisible'] = isVisible;
    json['order'] = order;
    json['type'] = type;
    return json;
  }
}
