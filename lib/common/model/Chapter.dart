import 'package:json_annotation/json_annotation.dart';

part 'Chapter.g.dart';

@JsonSerializable()
class Chapter {
  String title;
  String body;
  String cpContent;
  List<Map<String, int>> pageOffsets;

  Chapter(this.title, this.body, this.cpContent, this.pageOffsets);

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);

  String stringAtPageIndex(int index) {
    var offset = pageOffsets[index];
    return this.body.substring(offset['start'], offset['end']);
  }

  int get pageCount {
    return pageOffsets.length;
  }
}
