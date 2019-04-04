// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecommendBooks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendBooks _$RecommendBooksFromJson(Map<String, dynamic> json) {
  return RecommendBooks(
      json['_id'] as String,
      json['author'] as String,
      json['cover'] as String,
      json['shortIntro'] as String,
      json['title'] as String,
      json['hasCp'] as bool,
      json['isTop'] as bool,
      json['isSeleted'] as bool,
      json['showCheckBox'] as bool,
      json['isFromSD'] as bool,
      json['path'] as String,
      json['latelyFollower'] as int,
      (json['retentionRatio'] as num)?.toDouble(),
      json['updated'] as String,
      json['chaptersCount'] as int,
      json['lastChapter'] as String,
      json['recentReadingTime'] as String);
}

Map<String, dynamic> _$RecommendBooksToJson(RecommendBooks instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'cover': instance.cover,
      'shortIntro': instance.shortIntro,
      'title': instance.title,
      'hasCp': instance.hasCp,
      'isTop': instance.isTop,
      'isSeleted': instance.isSeleted,
      'showCheckBox': instance.showCheckBox,
      'isFromSD': instance.isFromSD,
      'path': instance.path,
      'latelyFollower': instance.latelyFollower,
      'retentionRatio': instance.retentionRatio,
      'updated': instance.updated,
      'chaptersCount': instance.chaptersCount,
      'lastChapter': instance.lastChapter,
      'recentReadingTime': instance.recentReadingTime
    };
