// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BooksBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksBean _$BooksBeanFromJson(Map<String, dynamic> json) {
  return BooksBean(
      json['_id'] as String,
      json['title'] as String,
      json['author'] as String,
      json['cover'] as String,
      json['shortIntro'] as String,
      json['site'] as String,
      json['majorCate'] as String,
      json['banned'] as int,
      json['latelyFollower'] as int,
      json['latelyFollowerBase'] as int,
      json['minRetentionRatio'] as String,
      json['retentionRatio'] as String);
}

Map<String, dynamic> _$BooksBeanToJson(BooksBean instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'cover': instance.cover,
      'shortIntro': instance.shortIntro,
      'site': instance.site,
      'majorCate': instance.majorCate,
      'banned': instance.banned,
      'latelyFollower': instance.latelyFollower,
      'latelyFollowerBase': instance.latelyFollowerBase,
      'minRetentionRatio': instance.minRetentionRatio,
      'retentionRatio': instance.retentionRatio
    };
