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
  late MockMqttServerClient mockMqttServerClient;
  late MqttClientImplementation mqttClientImplementation;
  late MqttClient<mqtt_client.MqttClientConnectionStatus, mqtt_client.MqttQos,
          List<mqtt_client.MqttReceivedMessage<mqtt_client.MqttMessage>>>
      mqttClient;

  setUp(
    () {
      mockMqttServerClient = MockMqttServerClient();
      mqttClientImplementation = MqttClientImplementation(
        mqttServerClient: mockMqttServerClient,
      );
      mqttClient = mqttClientImplementation;
    },
  );

  test(
    '''
      should ensure that [MqttClientImplementation] implements the [MqttClient]
      interface with [MqttClientConnectionStatus], [MqttQos]
      and [List<MqttReceivedMessage<MqttMessage>>] as generics
    ''',
    () {
      expect(
        mqttClientImplementation,
        isA<
            MqttClient<
                mqtt_client.MqttClientConnectionStatus,
                mqtt_client.MqttQos,
                List<
                    mqtt_client
                        .MqttReceivedMessage<mqtt_client.MqttMessage>>>>(),
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
          should forward call to [MqttServerClient.connect] once when
          [MqttClientImplementation.connectToBroker] is called
        ''',
        () async {
          final result = mqttClientImplementation.connectToBroker(
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
          [MqttClientImplementation.disconnectFromBroker] is called
        ''',
        () {
          mqttClientImplementation.disconnectFromBroker();

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
          [MqttClientImplementation.messagesFromBroker] getter is called
        ''',
        () {
          final result = mqttClientImplementation.messagesFromBroker;

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
          arguments when [MqttClientImplementation.subscribeToTopic] is called
        ''',
        () {
          mqttClientImplementation.subscribeToTopic(
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
          arguments when [MqttClientImplementation.unsubscribeFromTopic] is called
        ''',
        () {
          mqttClientImplementation.unsubscribeFromTopic(
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
