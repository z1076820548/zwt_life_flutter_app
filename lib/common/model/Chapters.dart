import 'package:json_annotation/json_annotation.dart';
part 'Chapters.g.dart';

@JsonSerializable()
class Chapters {
  String title;
  String link;
  bool unreadble;

  Chapters(this.title, this.link, this.unreadble);

  factory Chapters.fromJson(Map<String, dynamic> json) =>
      _$ChaptersFromJson(json);

  Map<String, dynamic> toJson() => _$ChaptersToJson(this);
}
