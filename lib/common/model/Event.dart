import 'package:json_annotation/json_annotation.dart';
import 'package:zwt_life_flutter_app/common/model/EventPayload.dart';
import 'package:zwt_life_flutter_app/common/model/Repository.dart';
import 'package:zwt_life_flutter_app/common/model/User.dart';

part 'Event.g.dart';

@JsonSerializable()
class Event{
  String id;
  String type;
  User actor;
  Repository repo;
  User org;
  EventPayload payload;
  @JsonKey(name: "public")
  bool isPublic;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  Event(
      this.id,
      this.type,
      this.actor,
      this.repo,
      this.org,
      this.payload,
      this.isPublic,
      this.createdAt,
      );

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}