import 'package:json_annotation/json_annotation.dart';
part 'TagBookBean.g.dart';

@JsonSerializable()
class TagBookBean {
  @JsonKey(name: "_id")
  String id;
   String title;
   String author;
   String shortIntro;
   String cover;
   String site;
   String cat;
   String majorCate;
   String minorCate;
   int latelyFollower;
   dynamic retentionRatio;
   String lastChapter;
   List<String> tags;


  TagBookBean(this.id, this.title, this.author, this.shortIntro, this.cover,
      this.site, this.cat, this.majorCate, this.minorCate, this.latelyFollower,
      this.retentionRatio, this.lastChapter, this.tags);

  factory TagBookBean.fromJson(Map<String, dynamic> json) =>
      _$TagBookBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TagBookBeanToJson(this);
}

