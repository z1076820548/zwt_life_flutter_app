import 'package:json_annotation/json_annotation.dart';
class Rating {

  int count;
  double score;
  bool isEffect;

  Rating(this.count, this.score, this.isEffect);

  Rating.fromJsonMap(Map<String, dynamic> map):
        count = map["count"],
        score = map["score"],
        isEffect = map["isEffect"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = count;
    data['score'] = score;
    data['isEffect'] = isEffect;
    return data;
  }
}
