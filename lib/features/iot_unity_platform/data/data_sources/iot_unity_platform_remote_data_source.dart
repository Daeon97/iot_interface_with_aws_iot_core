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
            onBadCertificateSupplied: (X509Certificate certificate) {
              streamController.sink.addError(
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
            },
            // onSubscribedToTopic: _onSubscribedToTopic,
            onSubscriptionToTopicFailed: (topicName) {
              streamController.sink.addError(
                TopicSubscriptionException(
                  message: sprintf(
                    res.topicSubscriptionExceptionMessage,
                    [
                      topicName,
                    ],
                  ),
                ),
              );
            },
            onDisconnectedFromBroker: () {
              streamController.sink.addError(
                UnsolicitedDisconnectionException(
                  message: sprintf(
                    res.unsolicitedDisconnectionExceptionMessage,
                    const <String>[],
                  ),
                ),
              );
            },
          );
        final connectionStatus = await mqttClient.connectToBroker();

        if (connectionStatus != null &&
            connectionStatus.state ==
                mqtt_client.MqttConnectionState.connected) {
          final subscription = mqttClient.subscribeToTopic(
            topicName: topicName,
            qualityOfService: mqtt_client.MqttQos.atMostOnce,
          );

          if (subscription != null) {
            final messagesFromBroker = mqttClient.messagesFromBroker;

            if (messagesFromBroker != null) {
              /*
                 TODO: Listen to the messagesFromBroker stream here instead of
                  'awaiting for'. Create a late variable then cancel the
                  subscription inside onCancel
               */
              await for (final message in messagesFromBroker) {
                for (final mqttReceivedMessage in message) {
                  if (mqttReceivedMessage.topic == topicName) {
                    final publishedMessage = mqttReceivedMessage.payload
                        as mqtt_client.MqttPublishMessage;
                    final uint8Buffer = publishedMessage.payload.message;
                    final uint8List = Uint8List.view(
                      uint8Buffer.buffer,
                      0,
                      uint8Buffer.length,
                    );
                    final utf8Decoded = utf8.decode(
                      uint8List,
                    );
                    final json =
                        jsonDecode(utf8Decoded) as Map<String, dynamic>;
                    streamController.sink.add(
                      IotUnityPlatformModel.fromJson(
                        json,
                      ),
                    );
                  } else {
                    streamController.sink.addError(
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
              }
            } else {
              streamController.sink.addError(
                NoMessagesFromBrokerException(
                  message: sprintf(
                    res.noMessagesFromBrokerExceptionMessage,
                    [
                      connectionStatus.state.name,
                      connectionStatus.returnCode?.name,
                      connectionStatus.disconnectionOrigin.name,
                    ],
                  ),
                ),
              );
            }
          } else {
            streamController.sink.addError(
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
        } else {
          streamController.sink.addError(
            CouldNotConnectToBrokerException(
              message: sprintf(
                res.couldNotConnectToBrokerExceptionMessage,
                [
                  connectionStatus?.state.name,
                  connectionStatus?.returnCode?.name,
                  connectionStatus?.disconnectionOrigin.name,
                ],
              ),
            ),
          );
        }
      },
      onCancel: () async {
        await streamController.sink.close();
        await streamController.close();
      },
    );
    return streamController.stream;
  }
}
