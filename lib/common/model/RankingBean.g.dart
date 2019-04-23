// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RankingBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingBean _$RankingBeanFromJson(Map<String, dynamic> json) {
  return RankingBean(
      json['_id'] as String,
      json['updated'] as String,
      json['title'] as String,
      json['tag'] as String,
      json['cover'] as String,
      json['__v'] as int,
      json['monthRank'] as String,
      json['totalRank'] as String,
      json['isSub'] as bool,
      json['collapse'] as bool,
      json['newX'] as bool,
      json['gender'] as String,
      json['priority'] as int,
      json['created'] as String,
      (json['books'] as List)
          ?.map((e) =>
              e == null ? null : BooksBean.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$RankingBeanToJson(RankingBean instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'updated': instance.updated,
      'title': instance.title,
      'tag': instance.tag,
      'cover': instance.cover,
      '__v': instance.v,
      'monthRank': instance.monthRank,
      'totalRank': instance.totalRank,
      'isSub': instance.isSub,
      'collapse': instance.collapse,
      'newX': instance.newX,
      'gender': instance.gender,
      'priority': instance.priority,
      'created': instance.created,
      'books': instance.books
    };
