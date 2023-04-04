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

  const testTopicName = 'test/topic/name';
  const testTopic1 = 'test/topic/1';
  const testQualityOfService = mqtt_client.MqttQos.atMostOnce;
  const testRootCertificateAuthoritykey = 'ROOT_CERTIFICATE_AUTHORITY';
  const testPrivateKeyKey = 'PRIVATE_KEY';
  const testDeviceCertificateKey = 'DEVICE_CERTIFICATE';
  const testEnableLogging = kDebugMode;

  const testIotUnityPlatformModel = IotUnityPlatformModel(
    humidity: 1.0,
    temperature: 1.0,
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
          should ensure that
          [IotUnityPlatformRemoteDataSourceImplementation.getDataFromIotUnityPlatform]
          returns a [Stream<IotUnityPlatformModel>]
        ''',
        () async {
          final result = iotUnityPlatformRemoteDataSourceImplementation
              .getDataFromIotUnityPlatform(
            topicName: testTopicName,
          );
          // ignore: cancel_subscriptions
          // final streamSubscription = result.listen((_) {});

          expect(
            result,
            isA<Stream<IotUnityPlatformModel>>(),
          );

          // try {
          //   await expectLater(
          //     result,
          //     emitsAnyOf(
          //       const [
          //         TypeMatcher<IotUnityPlatformModel>(),
          //         TypeMatcher<CustomException>(),
          //       ],
          //     ),
          //   );
          // } catch(error) {
          //   print(error);
          // }

          // streamSubscription.cancel();
        },
      );

      group(
        'onListen',
        () {
          test(
            '''
              should establish a security context first, ensure all other important
              stuff are initialized second and thereafter try to establish a connection
              to AWS IoT Core by calling [MqttClient.establishSecurityContext],
              [MqttClient.ensureAllOtherImportantStuffInitialized] and
              [MqttClient.connectToBroker] in that order when
              [IotUnityPlatformRemoteDataSourceImplementation.getDataFromIotUnityPlatform]
              is listened to
            ''',
            () {
              final result = iotUnityPlatformRemoteDataSourceImplementation
                  .getDataFromIotUnityPlatform(
                    topicName: testTopicName,
                  )
                  .listen((_) {});

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
                    onConnectedToBroker: argThat(
                      isA<Function>(),
                      named: 'onConnectedToBroker',
                    ),
                    onSubscribedToTopic: argThat(
                      isA<Function>(),
                      named: 'onSubscribedToTopic',
                    ),
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

              result.cancel();
            },
          );

          test(
            '''
              should expect a [CouldNotConnectToBrokerException] error when the
              connection status gotten as a result of invoking
              [MqttClient.connectToBroker] is [MqttConnectionState.disconnecting]
            ''',
            () {
              final expectedAnswer = mqtt_client.MqttClientConnectionStatus()
                ..state = mqtt_client.MqttConnectionState.disconnecting;
              when(
                mockMqttClient.connectToBroker(),
              ).thenAnswer(
                (_) async => expectedAnswer,
              );

              final result = iotUnityPlatformRemoteDataSourceImplementation
                  .getDataFromIotUnityPlatform(
                topicName: testTopicName,
              );

              expectLater(
                result,
                emitsError(
                  const TypeMatcher<CouldNotConnectToBrokerException>(),
                ),
              );
            },
          );

          test(
            '''
              should expect a [CouldNotConnectToBrokerException] error when the
              connection status gotten as a result of invoking
              [MqttClient.connectToBroker] is [MqttConnectionState.disconnected]
            ''',
            () {
              final expectedAnswer = mqtt_client.MqttClientConnectionStatus()
                ..state = mqtt_client.MqttConnectionState.disconnected;
              when(
                mockMqttClient.connectToBroker(),
              ).thenAnswer(
                (_) async => expectedAnswer,
              );

              final result = iotUnityPlatformRemoteDataSourceImplementation
                  .getDataFromIotUnityPlatform(
                topicName: testTopicName,
              );

              expectLater(
                result,
                emitsError(
                  const TypeMatcher<CouldNotConnectToBrokerException>(),
                ),
              );
            },
          );

          test(
            '''
              should expect a [CouldNotConnectToBrokerException] error when the
              connection status gotten as a result of invoking
              [MqttClient.connectToBroker] is [MqttConnectionState.faulted]
            ''',
            () {
              final expectedAnswer = mqtt_client.MqttClientConnectionStatus()
                ..state = mqtt_client.MqttConnectionState.faulted;
              when(
                mockMqttClient.connectToBroker(),
              ).thenAnswer(
                (_) async => expectedAnswer,
              );

              final result = iotUnityPlatformRemoteDataSourceImplementation
                  .getDataFromIotUnityPlatform(
                topicName: testTopicName,
              );

              expectLater(
                result,
                emitsError(
                  const TypeMatcher<CouldNotConnectToBrokerException>(),
                ),
              );
            },
          );

          test(
            '''
              should expect a [CouldNotConnectToBrokerException] error when the
              connection status gotten as a result of invoking
              [MqttClient.connectToBroker] is null
            ''',
            () {
              final expectedAnswer = Future.value(
                null,
              );
              when(
                mockMqttClient.connectToBroker(),
              ).thenAnswer(
                (_) => expectedAnswer,
              );

              final result = iotUnityPlatformRemoteDataSourceImplementation
                  .getDataFromIotUnityPlatform(
                topicName: testTopicName,
              );

              expectLater(
                result,
                emitsError(
                  const TypeMatcher<CouldNotConnectToBrokerException>(),
                ),
              );
            },
          );

          // group(
          //   'connectToBroker success',
          //   () {
          //     setUp(
          //       () async {
          //         final expectedAnswer =
          //             mqtt_client.MqttClientConnectionStatus()
          //               ..state = mqtt_client.MqttConnectionState.connected;
          //         when(
          //           mockMqttClient.connectToBroker(),
          //         ).thenAnswer(
          //           (_) async => expectedAnswer,
          //         );
          //       },
          //     );
          //
          //     test(
          //       '''
          //         should subscribe to a desired topic by calling [MqttClient.subscribeToTopic]
          //         when the connection to AWS IoT Core broker is successful
          //       ''',
          //       () {
          //         verify(
          //           mockMqttClient.subscribeToTopic(
          //             topicName: testTopicName,
          //             qualityOfService: testQualityOfService,
          //           ),
          //         ).called(1);
          //       },
          //     );
          //   },
          // );
        },
      );

      // group(
      //   'onCancel',
      //   () {
      //     test(
      //       '''
      //       ''',
      //       () {
      //         final result = iotUnityPlatformRemoteDataSourceImplementation
      //             .getDataFromIotUnityPlatform(
      //           topicName: testTopicName,
      //         );
      //         // result.listen((_) {})..cancel();
      //
      //         expect(
      //           result,
      //           emitsDone,
      //         );
      //       },
      //     );
      //   },
      // );
    },
  );

  //     group(
  //       'connectToBroker success',
  //       () {
  //

  //
  //         group(
  //           'subscribe success',
  //           () {
  //             setUp(
  //               () async {
  //                 final expectedAnswer = mqtt_client.Subscription();
  //                 when(
  //                   mockMqttClient.subscribeToTopic(
  //                     topicName: testTopicName,
  //                     qualityOfService: testQualityOfService,
  //                   ),
  //                 ).thenAnswer(
  //                   (_) => expectedAnswer,
  //                 );
  //               },
  //             );
  //
  //             test(
  //               '''
  //                 should call the [MqttClient.messagesFromBroker] getter once
  //                 when the client has successfully subscribed to the desired topic
  //               ''',
  //               () async {
  //                 await iotUnityPlatformRemoteDataSourceImplementation
  //                     .getDataFromIotUnityPlatform(
  //                       topicName: testTopicName,
  //                     )
  //                     .toList();
  //                 verify(
  //                   mockMqttClient.messagesFromBroker,
  //                 ).called(1);
  //               },
  //             );
  //
  //             /*TODO: Consider writing tests for logic inside await for */
  //
  //             group(
  //               'messages from broker',
  //               () {
  //                 test(
  //                   '''
  //                     should yield back a [Stream<IotUnityPlatformModel>]
  //                     corresponding to the appropriate topic when the broker
  //                     stream is not null
  //                   ''',
  //                   () {
  //                     final streamController = StreamController<
  //                         List<
  //                             mqtt_client.MqttReceivedMessage<
  //                                 mqtt_client.MqttMessage>>>();
  //                     // controller.
  //                     when(
  //                       mockMqttClient.messagesFromBroker,
  //                     ).thenAnswer(
  //                       (_) => streamController.stream,
  //                     );
  //
  //                     final result =
  //                         iotUnityPlatformRemoteDataSourceImplementation
  //                             .getDataFromIotUnityPlatform(
  //                       topicName: testTopicName,
  //                     );
  //
  //                     final expectedMessages = List.generate(
  //                       2,
  //                       (index) => IotUnityPlatformModel(
  //                         humidity: index == 0 ? 2.toDouble() : 4.toDouble(),
  //                         temperature: index == 0 ? 2.toDouble() : 4.toDouble(),
  //                       ),
  //                     );
  //
  //                     Uint8Buffer computeUint8Buffer(int index) => Uint8Buffer()
  //                       ..addAll(
  //                         Uint8List.fromList(
  //                           utf8.encode(
  //                             jsonEncode(
  //                               {
  //                                 'humidity': (index + 1).toDouble(),
  //                                 'temperature': (index + 1).toDouble(),
  //                               },
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //
  //                     final receivedMessages = List.generate(
  //                       5,
  //                       (index) => List.generate(
  //                         1,
  //                         (_) => mqtt_client.MqttReceivedMessage<
  //                             mqtt_client.MqttPublishMessage>(
  //                           (index + 1) % 2 != 0 ? testTopic1 : testTopicName,
  //                           mqtt_client.MqttPublishMessage()
  //                             ..payload.message = computeUint8Buffer(
  //                               index,
  //                             ),
  //                         ),
  //                       ),
  //                     );
  //
  //                     expectLater(
  //                       result,
  //                       emitsInOrder(
  //                         [
  //                           expectedMessages.first,
  //                           expectedMessages.last,
  //                         ],
  //                       ),
  //                     );
  //
  //                     for (final receivedMessagesList in receivedMessages) {
  //                       streamController.add(
  //                         receivedMessagesList,
  //                       );
  //                     }
  //                   },
  //                 );
  //
  //                 // test(
  //                 //   '''
  //                 //     should yield null when the stream coming from the
  //                 //     broker does not correspond to the appropriate topic
  //                 //   ''',
  //                 //   () {
  //                 //     final result =
  //                 //         iotUnityPlatformRemoteDataSourceImplementation
  //                 //             .getDataFromIotUnityPlatform(
  //                 //       topicName: testTopicName,
  //                 //     );
  //                 //
  //                 //     Uint8Buffer computeUint8Buffer(int index) => Uint8Buffer()
  //                 //       ..addAll(
  //                 //         Uint8List.fromList(
  //                 //           utf8.encode(
  //                 //             jsonEncode(
  //                 //               {
  //                 //                 'humidity': (index + 1).toDouble(),
  //                 //                 'temperature': (index + 1).toDouble(),
  //                 //               },
  //                 //             ),
  //                 //           ),
  //                 //         ),
  //                 //       );
  //                 //
  //                 //     final receivedMessages = List.generate(
  //                 //       5,
  //                 //       (index) => List.generate(
  //                 //         1,
  //                 //         (_) => mqtt_client.MqttReceivedMessage<
  //                 //             mqtt_client.MqttPublishMessage>(
  //                 //           testTopic1,
  //                 //           mqtt_client.MqttPublishMessage()
  //                 //             ..payload.message = computeUint8Buffer(
  //                 //               index,
  //                 //             ),
  //                 //         ),
  //                 //       ),
  //                 //     );
  //                 //
  //                 //     expectLater(
  //                 //       result,
  //                 //       emits(
  //                 //         null,
  //                 //       ),
  //                 //     );
  //                 //
  //                 //     for (final receivedMessagesList in receivedMessages) {
  //                 //       streamController.add(
  //                 //         receivedMessagesList,
  //                 //       );
  //                 //     }
  //                 //   },
  //                 // );
  //
  //                 test(
  //                   '''
  //                     should throw a [NoMessagesFromBrokerException] when
  //                     calling [MqttClient.messagesFromBroker] returns a null
  //                   ''',
  //                   () async {
  //                     when(
  //                       mockMqttClient.messagesFromBroker,
  //                     ).thenReturn(
  //                       null,
  //                     );
  //
  //                     final result =
  //                         await iotUnityPlatformRemoteDataSourceImplementation
  //                             .getDataFromIotUnityPlatform(
  //                               topicName: testTopicName,
  //                             )
  //                             .toList();
  //
  //                     expect(
  //                       result,
  //                       throwsA(
  //                         const TypeMatcher<NoMessagesFromBrokerException>(),
  //                       ),
  //                     );
  //                   },
  //                 );
  //               },
  //             );
  //           },
  //         );
  //       },
  //     );
  //
  //     // group(
  //     //   'connectToBroker failed',
  //     //   () {
  //     //     setUp(
  //     //       () {
  //     //         final expectedAnswer = mqtt_client.MqttClientConnectionStatus()
  //     //           ..state = mqtt_client.MqttConnectionState.disconnected
  //     //           ..disconnectionOrigin =
  //     //               mqtt_client.MqttDisconnectionOrigin.unsolicited;
  //     //         when(mockMqttClient.connectToBroker()).thenAnswer(
  //     //           (_) async => expectedAnswer,
  //     //         );
  //     //       },
  //     //     );
  //     //
  //     //     test(
  //     //       '''
  //     //         should throw [BrokerException] when the connection
  //     //         to AWS IoT Core broker fails
  //     //       ''',
  //     //       () async {
  //     //         final result =
  //     //             await iotUnityPlatformRemoteDataSourceImplementation
  //     //                 .getDataFromIotUnityPlatform(
  //     //                   topicName: testTopicName,
  //     //                 )
  //     //                 .toList();
  //     //         verifyNoMoreInteractions(
  //     //           mockMqttClient,
  //     //         );
  //     //         expect(
  //     //           result,
  //     //           throwsA(
  //     //             const TypeMatcher<BrokerException>(),
  //     //           ),
  //     //         );
  //     //       },
  //     //     );
  //     //   },
  //     // );
  //   },
  // );
}
