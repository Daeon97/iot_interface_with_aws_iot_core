import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/errors.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/data_sources.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/repositories/repositories.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/entities.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'iot_unity_platform_repository_implementation_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IotUnityPlatformRemoteDataSource>(),
])
void main() {
  late IotUnityPlatformRepositoryImplementation
      iotUnityPlatformRepositoryImplementation;
  late MockIotUnityPlatformRemoteDataSource
      mockIotUnityPlatformRemoteDataSource;

  // const testTopic1 = 'test/topic/1';
  // const testQualityOfService = mqtt_client.MqttQos.atMostOnce;
  // const testRootCertificateAuthoritykey = 'ROOT_CERTIFICATE_AUTHORITY';
  // const testPrivateKeyKey = 'PRIVATE_KEY';
  // const testDeviceCertificateKey = 'DEVICE_CERTIFICATE';
  // const testEnableLogging = kDebugMode;

  const testTopicName = 'test/topic';
  const testServer = 'test server';
  const testClientId = 'test client ID';
  const testPort = 1883;
  const testMaximumConnectionAttempts = 5;

  setUp(
    () {
      mockIotUnityPlatformRemoteDataSource =
          MockIotUnityPlatformRemoteDataSource();
      iotUnityPlatformRepositoryImplementation =
          IotUnityPlatformRepositoryImplementation(
        iotUnityPlatformRemoteDataSource: mockIotUnityPlatformRemoteDataSource,
      );
    },
  );

  // test(
  //   '''
  //     should ensure that
  //     [IotUnityPlatformRepositoryImplementation.getDataFromIotUnityPlatform]
  //     returns a [Stream<Either<Failure, IotUnityPlatformEntity>>]
  //   ''',
  //   () {
  //     final result =
  //         iotUnityPlatformRepositoryImplementation.getDataFromIotUnityPlatform(
  //       topicName: testTopicName,
  //     );
  //     expect(
  //       result,
  //       isA<Stream<Either<Failure, IotUnityPlatformEntity>>>,
  //     );
  //   },
  // );

  group(
    'getDataFromIotUnityPlatform',
    () {
      test(
        '''
          should ensure that
          [IotUnityPlatformRemoteDataSource.getDataFromIotUnityPlatform] stream
          is listened on with the same topic when
          [IotUnityPlatformRepositoryImplementation.getDataFromIotUnityPlatform]
          is listened on 
        ''',
        () {
          iotUnityPlatformRepositoryImplementation
              .getDataFromIotUnityPlatform(
                topicName: testTopicName,
              )
              .listen((event) {});

          verify(
            mockIotUnityPlatformRemoteDataSource
                .getDataFromIotUnityPlatform(
                  topicName: testTopicName,
                )
                .listen((event) {}),
          ).called(1);

          // expectLater(result, matcher);
        },
        timeout: const Timeout(
          Duration(
            seconds: 5,
          ),
        ),
      );
    },
  );
}
