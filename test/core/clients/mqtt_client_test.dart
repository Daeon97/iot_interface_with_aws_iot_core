import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/clients/mqtt_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt_server_client;

import 'mqtt_client_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<mqtt_server_client.MqttServerClient>(),
  MockSpec<SecurityContext>(),
])
void main() {
  late MqttClient mqttClient;
  late MockSecurityContext mockSecurityContext;
  late MockMqttServerClient mockMqttServerClient;

  setUp(
    () {
      mockSecurityContext = MockSecurityContext();
      mockMqttServerClient = MockMqttServerClient();
      mqttClient = MqttClient(
        securityContext: mockSecurityContext,
        mqttServerClient: mockMqttServerClient,
      );
    },
  );

  const testRootCertificateAuthority = 'test root certificate authority';
  const testPrivateKey = 'test private key';
  const testDeviceCertificate = 'test device certificate';

  group(
    'Security Context',
    () {
      test(
        '''
        should establish a security context when
        [MqttClient.establishSecurityContext] is called
      ''',
        () {
          mqttClient.establishSecurityContext(
            rootCertificateAuthority: testRootCertificateAuthority,
            privateKey: testPrivateKey,
            deviceCertificate: testDeviceCertificate,
          );

          verify(
            mockSecurityContext.setClientAuthoritiesBytes(
              utf8.encode(
                testRootCertificateAuthority,
              ),
            ),
          ).called(1);
          verify(
            mockSecurityContext.useCertificateChainBytes(
              utf8.encode(
                testDeviceCertificate,
              ),
            ),
          ).called(1);
          verify(
            mockSecurityContext.usePrivateKeyBytes(
              utf8.encode(
                testPrivateKey,
              ),
            ),
          ).called(1);
          verify(
            mockMqttServerClient.securityContext = mockSecurityContext,
          ).called(1);
          verify(
            mockMqttServerClient.secure = true,
          ).called(1);
        },
      );
    },
  );

  group(
    'Ensure all other important stuff initialized',
    () {
      const testEnableLogging = false;
      const testPort = 12345;
      const testKeepAlivePeriod = 10;
      const testClientId = 'test client ID';

      bool testOnBadCertificateSupplied(X509Certificate certificate) => false;

      void testOnConnectedToBroker() {
        return;
      }

      void testOnSubscribedToTopic(
        String topicName,
      ) {
        return;
      }

      void testOnSubscriptionToTopicFailed(
        String topicName,
      ) {
        return;
      }

      void testOnDisconnectedFromBroker() {
        return;
      }

      test(
        '''
          should ensure that all other important stuff are initialized
          when [MqttClient.ensureAllOtherImportantStuffInitialized] is called
        ''',
        () {
          mqttClient.ensureAllOtherImportantStuffInitialized(
            enableLogging: testEnableLogging,
            port: testPort,
            keepAlivePeriod: testKeepAlivePeriod,
            clientId: testClientId,
            onBadCertificateSupplied: testOnBadCertificateSupplied,
            onConnectedToBroker: testOnConnectedToBroker,
            onSubscribedToTopic: testOnSubscribedToTopic,
            onSubscriptionToTopicFailed: testOnSubscriptionToTopicFailed,
            onDisconnectedFromBroker: testOnDisconnectedFromBroker,
          );

          verify(
            mockMqttServerClient.logging(
              on: testEnableLogging,
            ),
          ).called(1);
          verify(
            mockMqttServerClient.port = testPort,
          ).called(1);
          verify(
            mockMqttServerClient.keepAlivePeriod = testKeepAlivePeriod,
          ).called(1);
          verify(
            mockMqttServerClient.clientIdentifier = testClientId,
          ).called(1);
          verify(
            mockMqttServerClient.onBadCertificate =
                testOnBadCertificateSupplied,
          ).called(1);
          verify(
            mockMqttServerClient.onConnected = testOnConnectedToBroker,
          ).called(1);
          verify(
            mockMqttServerClient.onSubscribed = testOnSubscribedToTopic,
          ).called(1);
          verify(
            mockMqttServerClient.onSubscribeFail =
                testOnSubscriptionToTopicFailed,
          ).called(1);
          verify(
            mockMqttServerClient.onDisconnected = testOnDisconnectedFromBroker,
          ).called(1);
        },
      );
    },
  );

  group(
    'Connect to broker',
    () {
      const testUsername = 'testUsername';
      const testPassword = 'testPassword';

      test(
        '''
          should call [MqttServerClient.connect] once when
          [MqttClient.connectToBroker] is called
        ''',
        () async {
          final result = mqttClient.connectToBroker(
            username: testUsername,
            password: testPassword,
          );

          verify(
            mockMqttServerClient.connect(
              testUsername,
              testPassword,
            ),
          ).called(1);
          verifyNoMoreInteractions(
            mockMqttServerClient,
          );
          expect(
            result,
            isA<Future<mqtt_client.MqttClientConnectionStatus?>>(),
          );
        },
      );
    },
  );

  group(
    'Disconnect from broker',
    () {
      test(
        '''
          should call [MqttServerClient.disconnect] once when
          [MqttClient.disconnectFromBroker] is called
        ''',
        () {
          mqttClient.disconnectFromBroker();

          verify(
            mockMqttServerClient.disconnect(),
          ).called(1);
          verifyNoMoreInteractions(
            mockMqttServerClient,
          );
        },
      );
    },
  );

  group(
    'Messages from broker',
    () {
      test(
        '''
          should call [MqttServerClient.updates] once when
          [MqttClient.messagesFromBroker] getter is called
        ''',
        () {
          final result = mqttClient.messagesFromBroker;

          verify(
            mockMqttServerClient.updates,
          ).called(1);
          verifyNoMoreInteractions(
            mockMqttServerClient,
          );
          expect(
            result,
            isA<
                Stream<
                    List<
                        mqtt_client
                            .MqttReceivedMessage<mqtt_client.MqttMessage>>>?>(),
          );
        },
      );
    },
  );

  group(
    'Subscribe to topic',
    () {
      const testTopicName = 'test/topic/name';
      const testQos = mqtt_client.MqttQos.atLeastOnce;

      test(
        '''
          should call [MqttServerClient.subscribe] once with the same
          arguments when [MqttClient.subscribeToTopic] is called
        ''',
        () {
          final result = mqttClient.subscribeToTopic(
            topicName: testTopicName,
            qualityOfService: testQos,
          );

          verify(
            mockMqttServerClient.subscribe(
              testTopicName,
              testQos,
            ),
          ).called(1);
          verifyNoMoreInteractions(
            mockMqttServerClient,
          );
          expect(
            result,
            isA<mqtt_client.Subscription?>(),
          );
        },
      );
    },
  );

  group(
    'Unsubscribe from topic',
    () {
      const testTopicName = 'test/topic/name';
      const testAcknowledgeUnsubscription = true;

      test(
        '''
          should call [MqttServerClient.unsubscribe] once with the same
          arguments when [MqttClient.unsubscribeFromTopic] is called
        ''',
        () {
          mqttClient.unsubscribeFromTopic(
            topicName: testTopicName,
            acknowledgeUnsubscription: testAcknowledgeUnsubscription,
          );

          verify(
            mockMqttServerClient.unsubscribe(
              testTopicName,
              expectAcknowledge: testAcknowledgeUnsubscription,
            ),
          ).called(1);
          verifyNoMoreInteractions(
            mockMqttServerClient,
          );
        },
      );
    },
  );
}
