import 'dart:convert';

import 'package:flutter_wan_android/generated/json/base/json_field.dart';

@JsonSerializable()
class ScoreRankListEntity {
  int? curPage;
  List<ScoreRankEntity>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  ScoreRankListEntity();

  factory ScoreRankListEntity.fromJson(Map<String, dynamic> json) =>
      $ScoreRankModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $ScoreRankModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ScoreRankEntity {
  int? coinCount;
  int? level;
  String? nickname;
  String? rank;
  int? userId;
  String? username;

  ScoreRankEntity();

  factory ScoreRankEntity.fromJson(Map<String, dynamic> json) =>
      $ScoreRankModelDatasFromJson(json);

  Map<String, dynamic> toJson() => $ScoreRankModelDatasToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
