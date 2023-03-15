import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/clients/clients.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/data_sources.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'iot_unity_platform_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MqttClient>(),
])
void main() {
  late MockMqttClient mockMqttClient;
  late IotUnityPlatformRemoteDataSourceImplementation
      iotUnityPlatformRemoteDataSourceImplementation;

  setUp(
    () {
      mockMqttClient = MockMqttClient();
      iotUnityPlatformRemoteDataSourceImplementation =
          IotUnityPlatformRemoteDataSourceImplementation(
        mqttClient: mockMqttClient,
      );
    },
  );

  const testUsername = 'test username';
  const testPassword = 'test password';

  const testTopicName = 'topic/name';

//   test(
//     '''
//       should establish connection to AWS IoT Core by calling
//       [MqttClient.connectToBroker] when
//       [IotUnityPlatformRemoteDataSourceImplementation.getDataFromIotUnityPlatform]
//       is called
//     ''',
//     () {
//       iotUnityPlatformRemoteDataSourceImplementation
//           .getDataFromIotUnityPlatform(
//         topicName: testTopicName,
//       );
// verifyInOrder([
//
// ],);
//     },
//   );

  // test(
  //   '''
  //     should establish connection to AWS IoT Core by calling
  //     [MqttClient.connectToBroker] when
  //     [IotUnityPlatformRemoteDataSourceImplementation.getDataFromIotUnityPlatform]
  //     is called
  //   ''',
  //       () {
  //     when(mockMqttClient.connectToBroker())
  //       },
  // );

  // test(
  //   '''
  //     should return [IotUnityPlatformModel] when
  //     [IotUnityPlatformRemoteDataSourceImplementation.getDataFromIotUnityPlatform]
  //     is called
  //   ''',
  //   () {},
  // );
}
