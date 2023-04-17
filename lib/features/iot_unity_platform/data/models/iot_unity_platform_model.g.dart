// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iot_unity_platform_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IotUnityPlatformModel _$IotUnityPlatformModelFromJson(
        Map<String, dynamic> json) =>
    IotUnityPlatformModel(
      humidity: (json['humidity'] as num).toDouble(),
      temperature: (json['temperature'] as num).toDouble(),
    );

Map<String, dynamic> _$IotUnityPlatformModelToJson(
        IotUnityPlatformModel instance) =>
    <String, dynamic>{
      'humidity': instance.humidity,
      'temperature': instance.temperature,
    };
