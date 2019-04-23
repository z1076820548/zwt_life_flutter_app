import 'package:json_annotation/json_annotation.dart';
import 'package:zwt_life_flutter_app/common/model/BooksBean.dart';

part 'RankingBean.g.dart';

@JsonSerializable()
class RankingBean {
  @JsonKey(name: "_id")
  String id;
  String updated;
  String title;
  String biTag;
  String cover;
  @JsonKey(name: "__v")
  int v;
  String monthRank;
  String totalRank;
  bool isSub;
  bool collapse;
  @JsonKey(name: 'new')
  bool newX;
  String gender;
  int priority;
  String created;
  List<BooksBean> books;

  RankingBean(
      this.id,
      this.updated,
      this.title,
      this.biTag,
      this.cover,
      this.v,
      this.monthRank,
      this.totalRank,
      this.isSub,
      this.collapse,
      this.newX,
      this.gender,
      this.priority,
      this.created,
      this.books);

  factory RankingBean.fromJson(Map<String, dynamic> json) =>
      _$RankingBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RankingBeanToJson(this);
}
