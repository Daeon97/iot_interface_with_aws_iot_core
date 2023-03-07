// ignore_for_file: public_member_api_docs

import 'package:mqtt_client/mqtt_client.dart';

// clean up this abstract class tomorrow
abstract class MqttClient<T> {
  const MqttClient();

  Future<MqttClientConnectionStatus> connectToBroker({
    String? username,
    String? password,
  });

  void disconnectFromBroker();

  void subscribeToTopic({
    required String topicName,
    required MqttQos qualityOfService,
  });

  void unsubscribeFromTopic({
    required String topicName,
    required bool acknowledgeUnsubscription,
  });

  ConnectCallback? onConnectedToBroker();

  DisconnectCallback? onDisconnectedFromBroker();

  SubscribeCallback? onSubscribedToTopic();

  UnsubscribeCallback onUnsubscribedFromTopic();

  Stream<List<MqttReceivedMessage<MqttMessage>>>? get updates;
}
