import 'package:json_annotation/json_annotation.dart';

part 'MaleBean.g.dart';

@JsonSerializable()
class MaleBean {
  @JsonKey(name: "_id")
  String id;
   String title;
   String cover;
   bool collapse;
   String monthRank;
   String totalRank;

  MaleBean(this.id, this.title, this.cover, this.collapse,
      this.monthRank, this.totalRank);

  factory MaleBean.fromJson(Map<String, dynamic> json) =>
      _$MaleBeanFromJson(json);

  Map<String, dynamic> toJson() => _$MaleBeanToJson(this);
}
