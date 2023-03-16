// ignore_for_file: public_member_api_docs

import 'package:iot_interface_with_aws_iot_core/core/clients/clients.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/resources.dart' as res;
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    mqttClient.establishSecurityContext(
      rootCertificateAuthority: dotenv.get(res.rootCertificateAuthorityKey),
      privateKey: dotenv.get(res.privateKeyKey),
      deviceCertificate: dotenv.get(res.deviceCertificateKey),
    );
    return Stream.value(
      const IotUnityPlatformModel(
        humidity: 1.0,
        temperature: 1.0,
      ),
    );
  }
}
