// ignore_for_file: public_member_api_docs

// consider removing this abstract class and just have a concrete class here
// having this abstract class is kindda overkill

import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt_server_client;

abstract class MqttClient<ConnectionStatus, Qos, Message> {
  const MqttClient();

  Future<ConnectionStatus?> connectToBroker({
    String? username,
    String? password,
  });

  void disconnectFromBroker();

  Stream<Message>? get messagesFromBroker;

  void subscribeToTopic({
    required String topicName,
    required Qos qualityOfService,
  });

  void unsubscribeFromTopic({
    required String topicName,
    required bool acknowledgeUnsubscription,
  });

// ConnectCallback? onConnectedToBroker();
//
// DisconnectCallback? onDisconnectedFromBroker();
//
// SubscribeCallback? onSubscribedToTopic();
//
// UnsubscribeCallback onUnsubscribedFromTopic();
//
// SecurityContext secureConnection(); and set secure to true
//
// keepalive, keepalive period, autoReconnect, on auto reconnect, on auto reconnected,
// on bad certificate, onSubscribeFail, pongCallback, resubscribeOnAutoReconnect,
//
// doAutoReconnect, getSubscriptionsStatus, internalDisconnect, logging,
// resubscribe
}

class MqttClientImplementation
    implements
        MqttClient<
            mqtt_client.MqttClientConnectionStatus,
            mqtt_client.MqttQos,
            List<mqtt_client.MqttReceivedMessage<mqtt_client.MqttMessage>>> {
  const MqttClientImplementation({
    required this.mqttServerClient,
  });

  final mqtt_server_client.MqttServerClient mqttServerClient;

  @override
  Future<mqtt_client.MqttClientConnectionStatus?> connectToBroker({
    String? username,
    String? password,
  }) =>
      mqttServerClient.connect(
        username,
        password,
      );

  @override
  void disconnectFromBroker() => mqttServerClient.disconnect();

  @override
  Stream<List<mqtt_client.MqttReceivedMessage<mqtt_client.MqttMessage>>>?
      get messagesFromBroker => mqttServerClient.updates;

  @override
  void subscribeToTopic({
    required String topicName,
    required mqtt_client.MqttQos qualityOfService,
  }) =>
      mqttServerClient.subscribe(
        topicName,
        qualityOfService,
      );

  @override
  void unsubscribeFromTopic({
    required String topicName,
    required bool acknowledgeUnsubscription,
  }) =>
      mqttServerClient.unsubscribe(
        topicName,
        expectAcknowledge: acknowledgeUnsubscription,
      );
}
