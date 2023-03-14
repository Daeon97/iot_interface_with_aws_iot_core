// ignore_for_file: public_member_api_docs

import 'package:iot_interface_with_aws_iot_core/core/resources/resources.dart'
    as res;
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt_server_client;

class MqttClient {
  MqttClient({
    required this.server,
    this.clientId,
    this.port,
    this.maximumConnectionAttempts,
  }) : _mqttServerClient = mqtt_server_client.MqttServerClient.withPort(
          server,
          clientId ?? res.defaultClientId,
          port ?? res.defaultMqttPort,
          maxConnectionAttempts:
              maximumConnectionAttempts ?? res.maximumConnectionAttempts,
        );

  final String server;
  final String? clientId;
  final int? port;
  final int? maximumConnectionAttempts;

  final mqtt_server_client.MqttServerClient _mqttServerClient;

  Future<mqtt_client.MqttClientConnectionStatus?> connectToBroker({
    String? username,
    String? password,
  }) =>
      _mqttServerClient.connect(
        username,
        password,
      );

  void disconnectFromBroker() => _mqttServerClient.disconnect();

  Stream<List<mqtt_client.MqttReceivedMessage<mqtt_client.MqttMessage>>>?
      get messagesFromBroker => _mqttServerClient.updates;

  void subscribeToTopic({
    required String topicName,
    required mqtt_client.MqttQos qualityOfService,
  }) =>
      _mqttServerClient.subscribe(
        topicName,
        qualityOfService,
      );

  void unsubscribeFromTopic({
    required String topicName,
    required bool acknowledgeUnsubscription,
  }) =>
      _mqttServerClient.unsubscribe(
        topicName,
        expectAcknowledge: acknowledgeUnsubscription,
      );
}
