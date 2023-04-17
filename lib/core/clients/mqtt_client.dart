// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt_server_client;

class MqttClient {
  MqttClient({
    required this.securityContext,
    required this.mqttServerClient,
  });

  final SecurityContext securityContext;
  final mqtt_server_client.MqttServerClient mqttServerClient;

  Future<void> establishSecurityContext({
    required String rootCertificateAuthorityAssetPath,
    required String privateKeyAssetPath,
    required String deviceCertificateAssetPath,
  }) async {
    securityContext
      ..setClientAuthoritiesBytes(
        (await rootBundle.load(
          rootCertificateAuthorityAssetPath,
        ))
            .buffer
            .asUint8List(),
      )
      ..useCertificateChainBytes(
        (await rootBundle.load(
          deviceCertificateAssetPath,
        ))
            .buffer
            .asUint8List(),
      )
      ..usePrivateKeyBytes(
        (await rootBundle.load(
          privateKeyAssetPath,
        ))
            .buffer
            .asUint8List(),
      );
    mqttServerClient
      ..securityContext = securityContext
      ..secure = true;
  }

  void ensureAllOtherImportantStuffInitialized({
    required bool Function(X509Certificate certificate)
        onBadCertificateSupplied,
    required void Function() onConnectedToBroker,
    required void Function(String) onSubscribedToTopic,
    required void Function(String) onSubscriptionToTopicFailed,
    required void Function() onDisconnectedFromBroker,
    bool enableLogging = true,
    int port = defaultMqttPort,
    int keepAlivePeriod = defaultKeepAlivePeriod,
    String clientId = defaultClientId,
  }) {
    mqttServerClient
      ..logging(
        on: enableLogging,
      )
      ..port = port
      ..keepAlivePeriod = keepAlivePeriod
      ..clientIdentifier = clientId
      // ..onBadCertificate = onBadCertificateSupplied
      ..onConnected = onConnectedToBroker
      ..onSubscribed = onSubscribedToTopic
      ..onSubscribeFail = onSubscriptionToTopicFailed
      ..onDisconnected = onDisconnectedFromBroker;
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

  mqtt_client.Subscription? subscribeToTopic({
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
// getSubscriptionsStatus*, internalDisconnect**, resubscribe*,
// mqttConnectMessage***!!!***
}
