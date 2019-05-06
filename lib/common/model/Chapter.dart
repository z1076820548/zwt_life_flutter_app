import 'package:json_annotation/json_annotation.dart';
import 'package:zwt_life_flutter_app/common/utils/util/stringutil.dart';

part 'Chapter.g.dart';

@JsonSerializable()
class Chapter {
  String title;
  String body;
  String cpContent;
  List<Map<String, int>> pageOffsets;

  Chapter(this.title, this.body, this.cpContent);

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);

  String stringAtPageIndex(int index) {
    var offset = pageOffsets[index];
    String s = StringUtils.formatContent(this.body);
    return s.substring(offset['start'], offset['end']);
  }

  int get pageCount {
    return pageOffsets.length;
  }
}
