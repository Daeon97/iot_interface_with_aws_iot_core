// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
        onBadCertificateSupplied: _onBadCertificateSupplied,
        // onSubscribedToTopic: _onSubscribedToTopic,
        onSubscriptionToTopicFailed: _onSubscriptionToTopicFailed,
        onDisconnectedFromBroker: _onDisconnectedFromBroker,
      );
    final connectionStatus = await mqttClient.connectToBroker();

    if (connectionStatus != null &&
        connectionStatus.state == mqtt_client.MqttConnectionState.connected) {
      final subscription = mqttClient.subscribeToTopic(
        topicName: topicName,
        qualityOfService: mqtt_client.MqttQos.atMostOnce,
      );

      if (subscription != null) {
        final messagesFromBroker = mqttClient.messagesFromBroker;

        if (messagesFromBroker != null) {
          await for (final message in messagesFromBroker) {
            final publishedMessage =
                message.last.payload as mqtt_client.MqttPublishMessage;
            final uint8Buffer = publishedMessage.payload.message;
            final uint8List = Uint8List.view(
              uint8Buffer.buffer,
              0,
              uint8Buffer.length,
            );
            final utf8Decoded = utf8.decode(
              uint8List,
            );
            final json = jsonDecode(utf8Decoded) as Map<String, dynamic>;
            yield IotUnityPlatformModel.fromJson(
              json,
            );
          }
        }
      } else {
        // TODO: Implement else block
      }
    } else {
      // TODO: Implement else block
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

  // void _onSubscribedToTopic(String topicName) {
  //   return;
  // }

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
