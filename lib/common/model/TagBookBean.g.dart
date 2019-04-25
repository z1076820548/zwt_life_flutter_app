// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagBookBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagBookBean _$TagBookBeanFromJson(Map<String, dynamic> json) {
  return TagBookBean(
      json['_id'] as String,
      json['title'] as String,
      json['author'] as String,
      json['shortIntro'] as String,
      json['cover'] as String,
      json['site'] as String,
      json['cat'] as String,
      json['majorCate'] as String,
      json['minorCate'] as String,
      json['latelyFollower'] as int,
      json['retentionRatio'],
      json['lastChapter'] as String,
      (json['tags'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$TagBookBeanToJson(TagBookBean instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'shortIntro': instance.shortIntro,
      'cover': instance.cover,
      'site': instance.site,
      'cat': instance.cat,
      'majorCate': instance.majorCate,
      'minorCate': instance.minorCate,
      'latelyFollower': instance.latelyFollower,
      'retentionRatio': instance.retentionRatio,
      'lastChapter': instance.lastChapter,
      'tags': instance.tags
    };
