// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Chapters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapters _$ChaptersFromJson(Map<String, dynamic> json) {
  return Chapters(json['title'] as String, json['link'] as String,
      json['unreadble'] as bool);
}

Map<String, dynamic> _$ChaptersToJson(Chapters instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'unreadble': instance.unreadble
    };
