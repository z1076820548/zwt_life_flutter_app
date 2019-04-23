import 'package:json_annotation/json_annotation.dart';

part 'BooksBean.g.dart';

@JsonSerializable()
class BooksBean {
  @JsonKey(name: "_id")
  String id;
  String cover;
  String site;
  String author;
  String majorCate;
  String minorCate;
  String title;
  String shortIntro;
  bool allowMonthly;
  int banned;
  int latelyFollower;
  String retentionRatio;

  BooksBean(this.id, this.title, this.author, this.cover, this.shortIntro,
      this.site, this.majorCate, this.banned, this.latelyFollower,
     this.retentionRatio,this.minorCate,this.allowMonthly);

  factory BooksBean.fromJson(Map<String, dynamic> json) =>
      _$BooksBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BooksBeanToJson(this);
}
