// ignore_for_file: public_member_api_docs

abstract class MqttClient<ConnectionStatus, Qos, Message> {
  const MqttClient();

  Future<ConnectionStatus> connectToBroker({
    String? username,
    String? password,
  });

  void disconnectFromBroker();

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
  Stream<Message>? get messagesFromBroker;
}
