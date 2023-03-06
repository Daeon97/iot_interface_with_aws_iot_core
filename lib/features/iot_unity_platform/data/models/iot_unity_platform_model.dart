// ignore_for_file: public_member_api_docs

import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'iot_unity_platform_model.g.dart';

@JsonSerializable()
class IotUnityPlatformModel extends IotUnityPlatformEntity {
  const IotUnityPlatformModel({
    required super.humidity,
    required super.temperature,
  });

  factory IotUnityPlatformModel.fromJson(Map<String, dynamic> json) =>
      _$IotUnityPlatformModelFromJson(json);

  Map<String, dynamic> toJson() => _$IotUnityPlatformModelToJson(this);
}
