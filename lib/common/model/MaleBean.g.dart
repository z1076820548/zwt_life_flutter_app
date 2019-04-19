// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MaleBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaleBean _$MaleBeanFromJson(Map<String, dynamic> json) {
  return MaleBean(
      json['_id'] as String,
      json['title'] as String,
      json['cover'] as String,
      json['collapse'] as bool,
      json['monthRank'] as String,
      json['totalRank'] as String);
}

Map<String, dynamic> _$MaleBeanToJson(MaleBean instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'cover': instance.cover,
      'collapse': instance.collapse,
      'monthRank': instance.monthRank,
      'totalRank': instance.totalRank
    };
