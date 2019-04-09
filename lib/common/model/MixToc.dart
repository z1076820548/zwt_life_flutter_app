import 'package:json_annotation/json_annotation.dart';
import 'package:zwt_life_flutter_app/common/model/Chapters.dart';
part 'MixToc.g.dart';

@JsonSerializable()
class MixToc {
  @JsonKey(name: "_id")
  String id;
  int chaptersCount1;
  String book;
  String chaptersUpdated;
  List<Chapters> chapters;
  String updated;

  MixToc(this.id, this.chaptersCount1, this.book, this.chaptersUpdated,
      this.chapters, this.updated);
  factory MixToc.fromJson(Map<String, dynamic> json) =>
      _$MixTocFromJson(json);

  Map<String, dynamic> toJson() => _$MixTocToJson(this);
}
