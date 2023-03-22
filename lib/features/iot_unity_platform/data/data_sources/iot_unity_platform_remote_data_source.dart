// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iot_interface_with_aws_iot_core/core/clients/clients.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/errors.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/resources.dart'
    as res;
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/models/models.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:sprintf/sprintf.dart';

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
  }) async* {
    mqttClient
      ..establishSecurityContext(
        rootCertificateAuthority: dotenv.get(res.rootCertificateAuthorityKey),
        privateKey: dotenv.get(res.privateKeyKey),
        deviceCertificate: dotenv.get(res.deviceCertificateKey),
      )
      ..ensureAllOtherImportantStuffInitialized(
        enableLogging: kDebugMode,
        // onBadCertificateSupplied: _onBadCertificateSupplied,
        onSubscriptionToTopicFailed: _onSubscriptionToTopicFailed,
        // onDisconnectedFromBroker: _onDisconnectedFromBroker,
      );
    final connectionStatus = await mqttClient.connectToBroker();
    if (connectionStatus != null &&
        connectionStatus.state == mqtt_client.MqttConnectionState.connected) {
      mqttClient.subscribeToTopic(
        topicName: topicName,
        qualityOfService: mqtt_client.MqttQos.atMostOnce,
      );
    } else {
      // throw BrokerException(
      //   message: sprintf(
      //     res.brokerExceptionMessage,
      //     [
      //       connectionStatus?.state.name,
      //       connectionStatus?.returnCode?.name,
      //       connectionStatus?.disconnectionOrigin.name,
      //     ],
      //   ),
      // );
    }
    // final stream = Stream.periodic(
    //   const Duration(
    //     seconds: 5,
    //   ),
    //   (_) => const IotUnityPlatformModel(
    //     humidity: 1.0,
    //     temperature: 1.0,
    //   ),
    // );
    //
    // await for (final s in stream) {
    //   yield IotUnityPlatformModel(
    //     humidity: s.humidity,
    //     temperature: s.temperature,
    //   );
    // }
  }

  bool _onBadCertificateSupplied(X509Certificate certificate) =>
      throw BadCertificateException(
        message: sprintf(
          res.badCertificateExceptionMessage,
          [
            certificate,
          ],
        ),
      );

  void _onSubscriptionToTopicFailed(String topicName) =>
      throw TopicSubscriptionException(
        message: sprintf(
          res.topicSubscriptionExceptionMessage,
          [
            topicName,
          ],
        ),
      );

  void _onDisconnectedFromBroker() => throw UnsolicitedDisconnectionException(
        message: sprintf(
          res.unsolicitedDisconnectionExceptionMessage,
          const <String>[],
        ),
      );
}
