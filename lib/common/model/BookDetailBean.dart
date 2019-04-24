import 'package:json_annotation/json_annotation.dart';
import 'package:zwt_life_flutter_app/common/model/Rating.dart';

part 'BookDetailBean.g.dart';

@JsonSerializable()
class BookDetailBean {
	@JsonKey(name: "_id")
  String id;
  String longIntro;
  String title;
  String majorCate;
  String minorCateV2;
  String creater;
  String minorCate;
  String author;
  String cover;
  String majorCateV2;
  bool isMakeMoneyLimit;
  bool isFineBook;
  int safelevel;
  bool allowFree;
  String originalAuthor;
  List<dynamic> anchors;
  String authorDesc;

  bool hasCopyright;
  int buytype;
  int sizetype;
  String superscript;
  int currency;
  String contentType;
  @JsonKey(name:'_le')
  bool le;
  bool allowMonthly;
  bool allowVoucher;
  bool allowBeanVoucher;
  bool hasCp;
  int banned;
  int postCount;
  int latelyFollower;
  int followerCount;
  int wordCount;
  int serializeWordCount;
  String retentionRatio;
  String updated;
  bool isSerial;
  int chaptersCount;
  String lastChapter;
  List<String> gender;
  List<String> tags;
  bool advertRead;
  String cat;
  bool donate;
	@JsonKey(name:'_gg')
  bool gg;
  bool isForbidForFreeApp;
  bool isAllowNetSearch;
  bool limit;
  String copyrightDesc;
	dynamic rating;
	dynamic discount;

	BookDetailBean(this.id, this.longIntro, this.title, this.majorCate,
			this.minorCateV2, this.creater, this.minorCate, this.author, this.cover,
			this.majorCateV2, this.isMakeMoneyLimit, this.isFineBook, this.safelevel,
			this.allowFree, this.rating,this.originalAuthor, this.anchors, this.authorDesc,
			 this.hasCopyright, this.buytype, this.sizetype,
			this.superscript, this.currency, this.contentType, this.le,
			this.allowMonthly, this.allowVoucher, this.allowBeanVoucher, this.hasCp,
			this.banned, this.postCount, this.latelyFollower, this.followerCount,
			this.wordCount, this.serializeWordCount, this.retentionRatio,
			this.updated, this.isSerial, this.chaptersCount, this.lastChapter,
			this.gender, this.tags, this.advertRead, this.cat, this.donate, this.gg,
			this.isForbidForFreeApp, this.isAllowNetSearch, this.limit,
			this.copyrightDesc, this.discount);

	factory BookDetailBean.fromJson(Map<String, dynamic> json) =>
			_$BookDetailBeanFromJson(json);

	Map<String, dynamic> toJson() => _$BookDetailBeanToJson(this);
}
