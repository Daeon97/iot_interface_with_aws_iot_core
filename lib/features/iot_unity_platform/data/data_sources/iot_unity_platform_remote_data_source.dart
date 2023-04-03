// ignore_for_file: public_member_api_docs

import 'dart:async';
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
  }) {
    late StreamController<IotUnityPlatformModel> streamController;
    StreamSubscription<
            List<mqtt_client.MqttReceivedMessage<mqtt_client.MqttMessage>>>?
        mqttReceivedMessagesStreamSubscription;

    streamController = StreamController<IotUnityPlatformModel>(
      onListen: () async {
        mqttClient
          ..establishSecurityContext(
            rootCertificateAuthority:
                dotenv.get(res.rootCertificateAuthorityKey),
            privateKey: dotenv.get(res.privateKeyKey),
            deviceCertificate: dotenv.get(res.deviceCertificateKey),
          )
          ..ensureAllOtherImportantStuffInitialized(
            enableLogging: kDebugMode,
            onBadCertificateSupplied: (X509Certificate certificate) =>
                _onBadCertificateSupplied(
              certificate,
              streamController.sink,
            ),
            onConnectedToBroker: () => _onConnectedToBroker(
              topicName,
            ),
            onSubscribedToTopic: (_) {
              mqttReceivedMessagesStreamSubscription = _onSubscribedToTopic(
                topicName,
                streamController.sink,
              );
            },
            onSubscriptionToTopicFailed: (_) => _onSubscriptionToTopicFailed(
              topicName,
              streamController.sink,
            ),
            onDisconnectedFromBroker: () => _onDisconnectedFromBroker(
              streamController.sink,
            ),
          );

        final connectionStatus = await mqttClient.connectToBroker();

        // if (connectionStatus?.state !=
        //     mqtt_client.MqttConnectionState.connected) {
        //   streamController.sink.addError(
        //     CouldNotConnectToBrokerException(
        //       message: sprintf(
        //         res.couldNotConnectToBrokerExceptionMessage,
        //         [
        //           connectionStatus?.state.name,
        //           connectionStatus?.returnCode?.name,
        //           connectionStatus?.disconnectionOrigin.name,
        //         ],
        //       ),
        //     ),
        //   );
        // }
      },
      onCancel: () async {
        await mqttReceivedMessagesStreamSubscription?.cancel();
        await streamController.sink.close();
        await streamController.close();
      },
    );
    return streamController.stream;
  }

  bool _onBadCertificateSupplied(
    X509Certificate certificate,
    StreamSink<IotUnityPlatformModel> streamSink,
  ) {
    streamSink.addError(
      BadCertificateException(
        message: sprintf(
          res.badCertificateExceptionMessage,
          [
            certificate,
          ],
        ),
      ),
    );
    return false;
  }

  void _onConnectedToBroker(String topicName) {
    mqttClient.subscribeToTopic(
      topicName: topicName,
      qualityOfService: mqtt_client.MqttQos.atMostOnce,
    );
  }

  StreamSubscription<
          List<mqtt_client.MqttReceivedMessage<mqtt_client.MqttMessage>>>?
      _onSubscribedToTopic(
    String topicName,
    StreamSink<IotUnityPlatformModel> streamSink,
  ) {
    StreamSubscription<
            List<mqtt_client.MqttReceivedMessage<mqtt_client.MqttMessage>>>?
        mqttReceivedMessagesStreamSubscription;
    final messagesFromBroker = mqttClient.messagesFromBroker;

    if (messagesFromBroker != null) {
      mqttReceivedMessagesStreamSubscription = messagesFromBroker.listen(
        (mqttReceivedMessages) {
          for (final mqttReceivedMessage in mqttReceivedMessages) {
            if (mqttReceivedMessage.topic == topicName) {
              final publishedMessage =
                  mqttReceivedMessage.payload as mqtt_client.MqttPublishMessage;
              final uint8Buffer = publishedMessage.payload.message;
              final uint8List = Uint8List.view(
                uint8Buffer.buffer,
                uint8Buffer.length,
              );
              final utf8Decoded = utf8.decode(
                uint8List,
              );
              final json = jsonDecode(utf8Decoded) as Map<String, dynamic>;
              streamSink.add(
                IotUnityPlatformModel.fromJson(
                  json,
                ),
              );
            } else {
              streamSink.addError(
                MessageTopicMismatchException(
                  message: sprintf(
                    res.messageTopicMismatchExceptionMessage,
                    [
                      mqttReceivedMessage.payload,
                      mqttReceivedMessage.topic,
                      (mqttReceivedMessage.payload
                              as mqtt_client.MqttPublishMessage)
                          .payload
                          .message,
                    ],
                  ),
                ),
              );
            }
          }
        },
      );
    } else {
      streamSink.addError(
        NoMessagesFromBrokerException(
          message: sprintf(
            res.noMessagesFromBrokerExceptionMessage,
            [
              messagesFromBroker,
            ],
          ),
        ),
      );
    }

    return mqttReceivedMessagesStreamSubscription;
  }

  void _onSubscriptionToTopicFailed(
    String topicName,
    StreamSink<IotUnityPlatformModel> streamSink,
  ) {
    streamSink.addError(
      TopicSubscriptionException(
        message: sprintf(
          res.topicSubscriptionExceptionMessage,
          [
            topicName,
          ],
        ),
      ),
    );
  }

  void _onDisconnectedFromBroker(
    StreamSink<IotUnityPlatformModel> streamSink,
  ) {
    streamSink.addError(
      UnsolicitedDisconnectionException(
        message: sprintf(
          res.unsolicitedDisconnectionExceptionMessage,
          const <String>[],
        ),
      ),
    );
  }
}
