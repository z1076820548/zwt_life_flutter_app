import 'package:json_annotation/json_annotation.dart';

part 'RecommendBooks.g.dart';
@JsonSerializable()
class RecommendBooks{
   @JsonKey(name: "_id")
   String id;
   String author;
   String cover;
   String shortIntro;
   String title;
   bool hasCp;
   bool isTop = false;
   bool isSeleted = false;
   bool showCheckBox = false;
   bool isFromSD = false;
   String path = "";
   int latelyFollower;
   dynamic retentionRatio;
   String updated = "";
   int chaptersCount;
   String lastChapter;
   String recentReadingTime = "";
   bool noUpdate = true;
   RecommendBooks(this.id, this.author, this.cover, this.shortIntro,
       this.title, this.hasCp, this.isTop, this.isSeleted, this.showCheckBox,
       this.isFromSD, this.path, this.latelyFollower, this.retentionRatio,
       this.updated, this.chaptersCount, this.lastChapter,
       this.recentReadingTime,this.noUpdate);

   factory RecommendBooks.fromJson(Map<String, dynamic> json) => _$RecommendBooksFromJson(json);
   Map<String, dynamic> toJson() => _$RecommendBooksToJson(this);

}