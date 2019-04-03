import 'package:json_annotation/json_annotation.dart';
import 'package:zwt_life_flutter_app/common/model/RecommendBooks.dart';

part 'Recommend.g.dart';

@JsonSerializable()
class Recommend {
  List<RecommendBooks> books;

  Recommend(this.books);

  factory Recommend.fromJson(Map<String, dynamic> json) =>
      _$RecommendFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendToJson(this);
}
