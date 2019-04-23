import 'package:json_annotation/json_annotation.dart';

part 'BooksBean.g.dart';

@JsonSerializable()
class BooksBean {
  @JsonKey(name: "_id")
   String id;
   String title;
  String author;
   String cover;
  String shortIntro;
  String site;
  String majorCate;
  int banned;
  int latelyFollower;
  int latelyFollowerBase;
  String minRetentionRatio;
  String retentionRatio;

  BooksBean(this.id, this.title, this.author, this.cover, this.shortIntro,
      this.site, this.majorCate, this.banned, this.latelyFollower,
      this.latelyFollowerBase, this.minRetentionRatio, this.retentionRatio);

  factory BooksBean.fromJson(Map<String, dynamic> json) =>
      _$BooksBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BooksBeanToJson(this);
}
