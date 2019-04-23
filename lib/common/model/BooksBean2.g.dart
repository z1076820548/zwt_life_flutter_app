// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BooksBean2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksBean2 _$BooksBean2FromJson(Map<String, dynamic> json) {
  return BooksBean2(
      json['_id'] as String,
      json['title'] as String,
      json['author'] as String,
      json['cover'] as String,
      json['shortIntro'] as String,
      json['site'] as String,
      json['banned'] as int,
      json['latelyFollower'] as int,
      json['latelyFollowerBase'] as int,
      json['minRetentionRatio'] as String,
      json['retentionRatio'] as String,
      json['majorCate'] as String,
      json['lastChapter'] as String,
      (json['tags'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$BooksBean2ToJson(BooksBean2 instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'cover': instance.cover,
      'shortIntro': instance.shortIntro,
      'site': instance.site,
      'banned': instance.banned,
      'latelyFollower': instance.latelyFollower,
      'latelyFollowerBase': instance.latelyFollowerBase,
      'minRetentionRatio': instance.minRetentionRatio,
      'retentionRatio': instance.retentionRatio,
      'majorCate': instance.majorCate,
      'lastChapter': instance.lastChapter,
      'tags': instance.tags
    };
