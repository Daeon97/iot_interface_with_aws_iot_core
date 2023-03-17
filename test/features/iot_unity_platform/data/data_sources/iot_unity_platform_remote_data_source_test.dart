import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/clients/clients.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/data_sources.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
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
      testLoadEnv('.env');
      mockMqttClient = MockMqttClient();
      iotUnityPlatformRemoteDataSourceImplementation =
          IotUnityPlatformRemoteDataSourceImplementation(
        mqttClient: mockMqttClient,
      );
    },
  );

  const testUsername = 'test username';
  const testPassword = 'test password';
  const testTopicName = 'test/topic/name';
  const testRootCertificateAuthoritykey = 'ROOT_CERTIFICATE_AUTHORITY';
  const testPrivateKeyKey = 'PRIVATE_KEY';
  const testDeviceCertificateKey = 'DEVICE_CERTIFICATE';
  const testServer = 'test server';
  const testMaximumConnectionAttempts = 5;
  const testEnableLogging = false;
  const testPort = 01564;
  const testKeepAlivePeriod = 50;
  const testClientId = 'test client ID';

  test(
    '''
      should establish a security context by calling
      [MqttClient.establishSecurityContext] when
      [IotUnityPlatformRemoteDataSourceImplementation.getDataFromIotUnityPlatform]
      is called
    ''',
    () async {
      iotUnityPlatformRemoteDataSourceImplementation
          .getDataFromIotUnityPlatform(
        topicName: testTopicName,
      );
      /*
      ** This gives me a null value error in untilCalled(...) **
      final expectedCall = mockMqttClient.establishSecurityContext(
        rootCertificateAuthority: dotenv.get(testRootCertificateAuthoritykey),
        privateKey: dotenv.get(testPrivateKeyKey),
        deviceCertificate: dotenv.get(testDeviceCertificateKey),
      );
      await untilCalled(
        expectedCall,
      );
      verify(expectedCall).called(1);
      */
      verify(
        mockMqttClient.establishSecurityContext(
          rootCertificateAuthority: dotenv.get(testRootCertificateAuthoritykey),
          privateKey: dotenv.get(testPrivateKeyKey),
          deviceCertificate: dotenv.get(testDeviceCertificateKey),
        ),
      ).called(1);
    },
  );

  test(
    '''
      should ensure all other important stuff are initialized when
      [MqttClient.ensureAllOtherImportantStuffInitialized] is called
    ''',
    () async {
      iotUnityPlatformRemoteDataSourceImplementation
          .getDataFromIotUnityPlatform(
        topicName: testTopicName,
      );
      final expectedCall =
          mockMqttClient.ensureAllOtherImportantStuffInitialized(
        enableLogging: testEnableLogging,
        port: testPort,
        keepAlivePeriod: testKeepAlivePeriod,
        clientId: testClientId,
      );
      await untilCalled(expectedCall);
      verify(
        expectedCall,
      ).called(1);
    },
  );

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
