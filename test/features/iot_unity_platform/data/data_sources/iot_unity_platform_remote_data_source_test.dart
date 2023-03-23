import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/clients/clients.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/errors.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/resources.dart'
    as res;
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/data_sources.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/models/models.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt_client;
import 'package:sprintf/sprintf.dart';
import 'package:typed_data/typed_data.dart';

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
  const testIotUnityPlatformModel = IotUnityPlatformModel(
    humidity: 1,
    temperature: 1,
  );

  // bool testOnBadCertificateSupplied(X509Certificate certificate) =>
  //     throw BadCertificateException(
  //       message: sprintf(
  //         res.badCertificateExceptionMessage,
  //         [
  //           certificate,
  //         ],
  //       ),
  //     );

  // void testOnSubscribedToTopic(
  //   String topicName,
  // ) {
  //   return;
  // }

  // void testOnSubscriptionToTopicFailed(
  //   String topicName,
  // ) =>
  //     throw TopicSubscriptionException(
  //       message: sprintf(
  //         res.topicSubscriptionExceptionMessage,
  //         [
  //           topicName,
  //         ],
  //       ),
  //     );

  // void testOnDisconnectedFromBroker() =>
  //     throw UnsolicitedDisconnectionException(
  //       message: sprintf(
  //         res.unsolicitedDisconnectionExceptionMessage,
  //         const <String>[],
  //       ),
  //     );

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
          verifyInOrder(
            [
              mockMqttClient.establishSecurityContext(
                rootCertificateAuthority:
                    dotenv.get(testRootCertificateAuthoritykey),
                privateKey: dotenv.get(testPrivateKeyKey),
                deviceCertificate: dotenv.get(testDeviceCertificateKey),
              ),
              mockMqttClient.ensureAllOtherImportantStuffInitialized(
                enableLogging: testEnableLogging,
                onBadCertificateSupplied: argThat(
                  isA<Function>(),
                  named: 'onBadCertificateSupplied',
                ),
                // onSubscribedToTopic: argThat(
                //   isA<Function>(),
                //   named: 'onSubscribedToTopic',
                // ),
                onSubscriptionToTopicFailed: argThat(
                  isA<Function>(),
                  named: 'onSubscriptionToTopicFailed',
                ),
                onDisconnectedFromBroker: argThat(
                  isA<Function>(),
                  named: 'onDisconnectedFromBroker',
                ),
              ),
              mockMqttClient.connectToBroker(),
            ],
          )
            ..[0].called(1)
            ..[1].called(1)
            ..[2].called(1);
        },
      );

      // group(
      //   '''
      //     [MqttClient.ensureAllOtherImportantStuffInitialized]
      //   ''',
      //   () {
      //     setUp(
      //       () async {
      //         await iotUnityPlatformRemoteDataSourceImplementation
      //             .getDataFromIotUnityPlatform(
      //               topicName: testTopicName,
      //             )
      //             .toList();
      //       },
      //     );
      //
      //     test(
      //       '''
      //         should ensure that [onBadCertificateSupplied], [onSubscribedToTopic],
      //         [onSubscriptionToTopicFailed] and [onDisconnectedFromBroker] are passed
      //         the correct arguments when [MqttClient.ensureAllOtherImportantStuffInitialized]
      //         is called
      //       ''',
      //       () async {
      //         // when(
      //         //   mockMqttClient.ensureAllOtherImportantStuffInitialized(
      //         //     enableLogging: anyNamed(
      //         //       'enableLogging',
      //         //     ),
      //         //     onBadCertificateSupplied: anyNamed(
      //         //       'onBadCertificateSupplied',
      //         //     ),
      //         //     onSubscribedToTopic: anyNamed(
      //         //       'onSubscribedToTopic',
      //         //     ),
      //         //     onSubscriptionToTopicFailed: anyNamed(
      //         //       'onSubscriptionToTopicFailed',
      //         //     ),
      //         //     onDisconnectedFromBroker: anyNamed(
      //         //       'onDisconnectedFromBroker',
      //         //     ),
      //         //   ),
      //         // ).thenReturn(const TypeMatcher<void>());
      //
      //         verify(
      //           () => mockMqttClient.ensureAllOtherImportantStuffInitialized(
      //             enableLogging: testEnableLogging,
      //             // onBadCertificateSupplied: (_) => throwsA(
      //             //   TypeMatcher<BadCertificateException>(),
      //             // ),
      //             onDisconnectedFromBroker: () => throwsA(
      //               const TypeMatcher<UnsolicitedDisconnectionException>(),
      //             ),
      //             onSubscriptionToTopicFailed: (_) => throwsA(
      //               const TypeMatcher<TopicSubscriptionException>(),
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // );

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
                  qualityOfService: testQualityOfService,
                ),
              ).called(1);
            },
          );

          group(
            'subscribe success',
            () {
              setUp(
                () async {
                  final expectedAnswer = mqtt_client.Subscription();
                  when(
                    mockMqttClient.subscribeToTopic(
                      topicName: testTopicName,
                      qualityOfService: testQualityOfService,
                    ),
                  ).thenAnswer(
                    (_) => expectedAnswer,
                  );
                },
              );

              test(
                '''
                  should call the [MqttClient.messagesFromBroker] getter
                  when the client has successfully subscribed to the desired topic
                ''',
                () async {
                  await iotUnityPlatformRemoteDataSourceImplementation
                      .getDataFromIotUnityPlatform(
                        topicName: testTopicName,
                      )
                      .toList();
                  verify(
                    mockMqttClient.messagesFromBroker,
                  ).called(1);
                },
              );

              group(
                'messages from broker',
                () {
                  setUp(
                    () {
                      final a = jsonEncode(
                        jsonDecode(
                          fixture(
                            'iot_unity_platform_data_integers.json',
                          ),
                        ),
                      );
                      final b = mqtt_client.MqttReceivedMessage<
                          mqtt_client.MqttPublishMessage>(
                        testTopicName,
                        mqtt_client.MqttPublishMessage()
                          ..payload.message = Uint8Buffer(5),
                      );
                      final iterables = <
                          mqtt_client
                              .MqttReceivedMessage<mqtt_client.MqttMessage>>[];
                      // final expectedAnswer = Stream.fromIterable(
                      //   const Duration(
                      //     seconds: 5,
                      //   ),
                      //   (_) => testIotUnityPlatformModel,
                      // );
                      // when(
                      //   mockMqttClient.messagesFromBroker,
                      // ).thenAnswer(
                      //   (_) => expectedAnswer,
                      // );
                    },
                  );

                  // test(
                  //   '''
                  //     should parse and yield a stream of messages from the broker
                  //     corresponding to the desired topic when the messages
                  //     from broker stream is not null
                  //   ''',
                  //   () async {
                  //     await iotUnityPlatformRemoteDataSourceImplementation
                  //         .getDataFromIotUnityPlatform(
                  //           topicName: testTopicName,
                  //         )
                  //         .toList();
                  //   },
                  // );
                },
              );
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
