import 'package:json_annotation/json_annotation.dart';
import 'package:zwt_life_flutter_app/common/model/User.dart';

part 'ReleaseAsset.g.dart';

@JsonSerializable()
class ReleaseAsset {
  int id;
  String name;
  String label;
  User uploader;
  @JsonKey(name: "content_type")
  String contentType;
  String state;
  int size;
  int downloadCout;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;
  @JsonKey(name: "browser_download_url")
  String downloadUrl;

  ReleaseAsset(
      this.id,
      this.name,
      this.label,
      this.uploader,
      this.contentType,
      this.state,
      this.size,
      this.downloadCout,
      this.createdAt,
      this.updatedAt,
      this.downloadUrl,
      );

  factory ReleaseAsset.fromJson(Map<String, dynamic> json) => _$ReleaseAssetFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseAssetToJson(this);
}