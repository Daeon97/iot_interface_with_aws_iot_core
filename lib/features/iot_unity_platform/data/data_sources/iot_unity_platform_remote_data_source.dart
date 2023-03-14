// ignore_for_file: public_member_api_docs

import 'package:iot_interface_with_aws_iot_core/core/clients/clients.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/models/models.dart';

abstract class IotUnityPlatformRemoteDataSource {
  const IotUnityPlatformRemoteDataSource();

  Stream<IotUnityPlatformModel> getDataFromIotUnityPlatform({
    required String topicName,
  });
}

class IotUnityPlatformRemoteDataSourceImplementation
    implements IotUnityPlatformRemoteDataSource {
  const IotUnityPlatformRemoteDataSourceImplementation({
    required this.mqttClient,
  });

  final MqttClient mqttClient;

  @override
  Stream<IotUnityPlatformModel> getDataFromIotUnityPlatform({
    required String topicName,
  }) {
    // TODO: implement getDataFromIotUnityPlatform
    throw UnimplementedError();
  }
}
