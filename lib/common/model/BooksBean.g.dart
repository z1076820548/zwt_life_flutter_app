// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BooksBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksBean _$BooksBeanFromJson(Map<String, dynamic> json) {
  return BooksBean(
      (json['tags'] as List)?.map((e) => e as String)?.toList(),
      json['_id'] as String,
      json['title'] as String,
      json['author'] as String,
      json['cover'] as String,
      json['shortIntro'] as String,
      json['site'] as String,
      json['majorCate'] as String,
      json['banned'] as int,
      json['latelyFollower'] as int,
      json['retentionRatio'],
      json['minorCate'] as String,
      json['allowMonthly'] as bool,
      json['cat'] as String);
}

Map<String, dynamic> _$BooksBeanToJson(BooksBean instance) => <String, dynamic>{
      '_id': instance.id,
      'cover': instance.cover,
      'site': instance.site,
      'author': instance.author,
      'majorCate': instance.majorCate,
      'minorCate': instance.minorCate,
      'title': instance.title,
      'cat': instance.cat,
      'shortIntro': instance.shortIntro,
      'allowMonthly': instance.allowMonthly,
      'banned': instance.banned,
      'latelyFollower': instance.latelyFollower,
      'retentionRatio': instance.retentionRatio,
      'tags': instance.tags
    };
