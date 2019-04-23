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
      json['retentionRatio'].toString(),
      json['minorCate'] as String,
      json['allowMonthly'] as bool);
}

Map<String, dynamic> _$BooksBeanToJson(BooksBean instance) => <String, dynamic>{
      '_id': instance.id,
      'cover': instance.cover,
      'site': instance.site,
      'author': instance.author,
      'majorCate': instance.majorCate,
      'minorCate': instance.minorCate,
      'title': instance.title,
      'shortIntro': instance.shortIntro,
      'allowMonthly': instance.allowMonthly,
      'banned': instance.banned,
      'latelyFollower': instance.latelyFollower,
      'retentionRatio': instance.retentionRatio
    };
