import 'package:json_annotation/json_annotation.dart';

part 'BooksBean2.g.dart';

@JsonSerializable()
class BooksBean2 {
  @JsonKey(name: "_id")
   String id;
   String title;
  String author;
   String cover;
  String shortIntro;
  String site;
  int banned;
  int latelyFollower;
  int latelyFollowerBase;
  String minRetentionRatio;
  String retentionRatio;
  String majorCate;
  String lastChapter;
  List<String> tags;


  BooksBean2(this.id, this.title, this.author, this.cover, this.shortIntro,
      this.site,  this.banned, this.latelyFollower,
      this.latelyFollowerBase, this.minRetentionRatio, this.retentionRatio,
      this.majorCate, this.lastChapter, this.tags);

  factory BooksBean2.fromJson(Map<String, dynamic> json) =>
      _$BooksBean2FromJson(json);

  Map<String, dynamic> toJson() => _$BooksBean2ToJson(this);
}
