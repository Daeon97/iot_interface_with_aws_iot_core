import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/clients/clients.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/errors.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/resources.dart'
    as res;
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/data_sources.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;

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

  // const testUsername = 'test username';
  // const testPassword = 'test password';
  const testTopicName = 'test/topic/name';
  const testQualityOfService = mqtt_client.MqttQos.atMostOnce;
  const testRootCertificateAuthoritykey = 'ROOT_CERTIFICATE_AUTHORITY';
  const testPrivateKeyKey = 'PRIVATE_KEY';
  const testDeviceCertificateKey = 'DEVICE_CERTIFICATE';
  const testServer = 'test server';
  const testMaximumConnectionAttempts = 5;
  const testEnableLogging = kDebugMode;
  const testPort = res.defaultMqttPort;
  const testKeepAlivePeriod = res.defaultKeepAlivePeriod;
  const testClientId = res.defaultClientId;

  group(
    'getDataFromIotUnityPlatform',
    () {
      test(
        '''
        should establish a security context first, ensure all other important
        stuff are initialized second and thereafter try to establish a connection
        to AWS IoT Core by calling [MqttClient.establishSecurityContext],
        [MqttClient.ensureAllOtherImportantStuffInitialized] and
        [MqttClient.connectToBroker] in that order when
        [IotUnityPlatformRemoteDataSourceImplementation.getDataFromIotUnityPlatform]
        is called
      ''',
        () async {
          await iotUnityPlatformRemoteDataSourceImplementation
              .getDataFromIotUnityPlatform(
                topicName: testTopicName,
              )
              .toList();
          verifyInOrder([
            mockMqttClient.establishSecurityContext(
              rootCertificateAuthority:
                  dotenv.get(testRootCertificateAuthoritykey),
              privateKey: dotenv.get(testPrivateKeyKey),
              deviceCertificate: dotenv.get(testDeviceCertificateKey),
            ),
            mockMqttClient.ensureAllOtherImportantStuffInitialized(
              enableLogging: testEnableLogging,
              port: testPort,
              keepAlivePeriod: testKeepAlivePeriod,
              clientId: testClientId,
            ),
            mockMqttClient.connectToBroker(),
          ])
            ..first.called(1)
            ..[1].called(1)
            ..last.called(1);
        },
      );

      /*
    TODO: Write tests for when [MqttClient.onBadCertificateSupplied],
      [MqttClient.onSubscriptionToTopicFailed]
      and [MqttClient.onDisconnectedFromBroker] are called by
      [IotUnityPlatformRemoteDataSourceImplementation.getDataFromIotUnityPlatform]
      before implementing them
    */

      group(
        'connectToBroker success',
        () {
          setUp(
            () async {
              final expectedAnswer = mqtt_client.MqttClientConnectionStatus()
                ..state = mqtt_client.MqttConnectionState.connected;
              when(
                mockMqttClient.connectToBroker(),
              ).thenAnswer(
                (_) async => expectedAnswer,
              );
            },
          );

          test(
            '''
              should subscribe to a desired topic by calling [MqttClient.subscribeToTopic]
              when the connection to AWS IoT Core broker is successful
            ''',
            () async {
              await iotUnityPlatformRemoteDataSourceImplementation
                  .getDataFromIotUnityPlatform(
                    topicName: testTopicName,
                  )
                  .toList();
              verify(
                mockMqttClient.subscribeToTopic(
                  topicName: testTopicName,
                  qualityOfService: mqtt_client.MqttQos.atMostOnce,
                ),
              ).called(1);
            },
          );

          group(
            'subscribe success',
            () {
              //.
            },
          );
        },
      );

      // group(
      //   'connectToBroker failed',
      //   () {
      //     setUp(
      //       () {
      //         final expectedAnswer = mqtt_client.MqttClientConnectionStatus()
      //           ..state = mqtt_client.MqttConnectionState.disconnected
      //           ..disconnectionOrigin =
      //               mqtt_client.MqttDisconnectionOrigin.unsolicited;
      //         when(mockMqttClient.connectToBroker()).thenAnswer(
      //           (_) async => expectedAnswer,
      //         );
      //       },
      //     );
      //
      //     test(
      //       '''
      //         should throw [BrokerException] when the connection
      //         to AWS IoT Core broker fails
      //       ''',
      //       () async {
      //         final result =
      //             await iotUnityPlatformRemoteDataSourceImplementation
      //                 .getDataFromIotUnityPlatform(
      //                   topicName: testTopicName,
      //                 )
      //                 .toList();
      //         verifyNoMoreInteractions(
      //           mockMqttClient,
      //         );
      //         expect(
      //           result,
      //           throwsA(
      //             const TypeMatcher<BrokerException>(),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // );
    },
  );

  // test(
  //   '''
  //     should return [IotUnityPlatformModel] when
  //     [IotUnityPlatformRemoteDataSourceImplementation.getDataFromIotUnityPlatform]
  //     is called
  //   ''',
  //   () {},
  // );
}
