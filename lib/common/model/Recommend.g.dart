// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Recommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommend _$RecommendFromJson(Map<String, dynamic> json) {
  return Recommend((json['books'] as List)
      ?.map((e) =>
          e == null ? null : RecommendBooks.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$RecommendToJson(Recommend instance) =>
    <String, dynamic>{'books': instance.books};
