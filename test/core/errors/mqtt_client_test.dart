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

  test(
    '''
      //.
    ''',
    () {},
  );
}
