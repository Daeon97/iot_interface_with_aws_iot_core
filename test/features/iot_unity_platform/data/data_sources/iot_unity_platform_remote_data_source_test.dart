import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/clients/clients.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/data_sources.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt_server_client;

// import 'iot_unity_platform_remote_data_source_test.mocks.dart';
//
// @GenerateNiceMocks([
//   MockSpec<
//       MqttClient<mqtt_client.MqttClientConnectionStatus, mqtt_client.MqttQos,
//           List<mqtt_client.MqttReceivedMessage<mqtt_client.MqttMessage>>>>(),
// ])
// void main() {
//   late MockMqttClient mockMqttClient;
//   late IotUnityPlatformRemoteDataSourceImplementation
//       iotUnityPlatformRemoteDataSourceImplementation;
//
//   setUp(
//     () {
//       iotUnityPlatformRemoteDataSourceImplementation =
//           IotUnityPlatformRemoteDataSourceImplementation(mockMqttClient);
//     },
//   );
// }
