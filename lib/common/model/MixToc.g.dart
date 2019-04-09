// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MixToc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MixToc _$MixTocFromJson(Map<String, dynamic> json) {
  return MixToc(
      json['_id'] as String,
      json['chaptersCount1'] as int,
      json['book'] as String,
      json['chaptersUpdated'] as String,
      (json['chapters'] as List)
          ?.map((e) =>
              e == null ? null : Chapters.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['updated'] as String);
}

Map<String, dynamic> _$MixTocToJson(MixToc instance) => <String, dynamic>{
      '_id': instance.id,
      'chaptersCount1': instance.chaptersCount1,
      'book': instance.book,
      'chaptersUpdated': instance.chaptersUpdated,
      'chapters': instance.chapters,
      'updated': instance.updated
    };
