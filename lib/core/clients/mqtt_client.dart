// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:io';

import 'package:iot_interface_with_aws_iot_core/core/resources/resources.dart'
    as res;
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt_server_client;

class MqttClient {
  MqttClient({
    required this.securityContext,
    required this.mqttServerClient,
  });

  final SecurityContext securityContext;
  final mqtt_server_client.MqttServerClient mqttServerClient;

  void establishSecurityContext({
    required String rootCertificateAuthority,
    required String privateKey,
    required String deviceCertificate,
  }) {
    securityContext
      ..setClientAuthoritiesBytes(
        utf8.encode(
          rootCertificateAuthority,
        ),
      )
      ..useCertificateChainBytes(
        utf8.encode(
          deviceCertificate,
        ),
      )
      ..usePrivateKeyBytes(
        utf8.encode(
          privateKey,
        ),
      );
    mqttServerClient
      ..securityContext = securityContext
      ..secure = true;
  }

  void ensureAllOtherImportantStuffInitialized({
    bool enableLogging = true,
    int port = res.defaultMqttPort,
    int keepAlivePeriod = res.defaultKeepAlivePeriod,
    String clientId = res.defaultClientId,
  }) {
    mqttServerClient
      ..logging(
        on: enableLogging,
      )
      ..port = port
      ..keepAlivePeriod = keepAlivePeriod
      ..clientIdentifier = clientId
      ..onBadCertificate = onBadCertificateSupplied
      ..onSubscribeFail = onSubscriptionToTopicFailed
      ..onDisconnected = onDisconnectedFromBroker;
  }

  bool onBadCertificateSupplied(X509Certificate certificate) {
    /*
    TODO: consider returning false so the error
     is thrown back to the user and not ignored
    */
    throw UnimplementedError();
  }

  void onSubscriptionToTopicFailed(
    String topicName,
  ) {
    /*
    TODO: Implement onSubscriptionToTopicFailed
    */
    throw UnimplementedError();
  }

  void onDisconnectedFromBroker() {
    /*
    TODO: Implement onDisconnectedFromBroker
    */
    throw UnimplementedError();
  }

  Future<mqtt_client.MqttClientConnectionStatus?> connectToBroker({
    String? username,
    String? password,
  }) =>
      mqttServerClient.connect(
        username,
        password,
      );

  void disconnectFromBroker() => mqttServerClient.disconnect();

  Stream<List<mqtt_client.MqttReceivedMessage<mqtt_client.MqttMessage>>>?
      get messagesFromBroker => mqttServerClient.updates;

  void subscribeToTopic({
    required String topicName,
    required mqtt_client.MqttQos qualityOfService,
  }) =>
      mqttServerClient.subscribe(
        topicName,
        qualityOfService,
      );

  void unsubscribeFromTopic({
    required String topicName,
    required bool acknowledgeUnsubscription,
  }) =>
      mqttServerClient.unsubscribe(
        topicName,
        expectAcknowledge: acknowledgeUnsubscription,
      );

// keepalive*, autoReconnect*, on auto reconnect*, on auto reconnected*,
// pongCallback*, resubscribeOnAutoReconnect*, doAutoReconnect*,
// getSubscriptionsStatus*, internalDisconnect**, resubscribe*
}
