import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/clients/clients.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt_server_client;

import 'mqtt_client_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<mqtt_server_client.MqttServerClient>(),
])
void main() {
  late MqttClient mqttClient;
  late MockMqttServerClient mockMqttServerClient;

  const testServer = 'test server';
  const testClientId = 'test client ID';
  const testPort = 1883;
  const testMaximumConnectionAttempts = 5;

  setUp(
    () {
      mqttClient = MqttClient(
        server: testServer,
        clientId: testClientId,
        port: testPort,
        maximumConnectionAttempts: testMaximumConnectionAttempts,
      );
      mockMqttServerClient = MockMqttServerClient();
    },
  );

  test(
    '''
      should instantiate [MqttServerClient] with the same arguments
      when [MqttClient] is instantiated
    ''',
    () {
      verify(
        mockMqttServerClient.server == testServer,
      );
      verify(
        mockMqttServerClient.clientIdentifier == testClientId,
      );
      verify(
        mockMqttServerClient.port == testPort,
      );
      verify(
        mockMqttServerClient.maxConnectionAttempts ==
            testMaximumConnectionAttempts,
      );
      verifyNoMoreInteractions(
        mockMqttServerClient,
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
          mqttClient.subscribeToTopic(
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
