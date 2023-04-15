import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/failure.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/iot_unity_platform_entity.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/usecases/get_data_from_iot_unity_platform_use_case.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'iot_unity_platform_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetDataFromIotUnityPlatformUseCase>(),
])
void main() {
  late MockGetDataFromIotUnityPlatformUseCase
      mockGetDataFromIotUnityPlatformUseCase;
  late IotUnityPlatformBloc iotUnityPlatformBloc;

  setUp(
    () {
      mockGetDataFromIotUnityPlatformUseCase =
          MockGetDataFromIotUnityPlatformUseCase();
      iotUnityPlatformBloc = IotUnityPlatformBloc(
        mockGetDataFromIotUnityPlatformUseCase,
      );
    },
  );

  tearDown(() {
    iotUnityPlatformBloc.close();
  });

  group(
    'IotUnityPlatformBloc',
    () {
      late String testTopicName;

      setUp(
        () {
          testLoadEnv('.env');
          testTopicName = dotenv.env[iotUnityPlatformTopicNameKey]!;
        },
      );

      test(
        '''
          should ensure that [IotUnityPlatformInitialState]
          is emitted as initial state
        ''',
        () {
          expect(
            iotUnityPlatformBloc.state,
            const IotUnityPlatformInitialState(),
          );
        },
      );

      group(
        'ListenDataFromIotUnityPlatformEvent',
        () {
          const testIotUnityPlatformEntity = IotUnityPlatformEntity(
            humidity: 1.0,
            temperature: 1.0,
          );
          const Failure testFailure = CouldNotConnectToBrokerFailure(
            message: 'test message',
          );

          blocTest<IotUnityPlatformBloc, IotUnityPlatformState>(
            '''
              should emit [GettingDataFromIotUnityPlatformState] first, call
              [IotUnityPlatformBloc.getDataFromIotUnityPlatformUseCase] with
              the appropriate topic name and then
              [GotDataFromIotUnityPlatformState] subsequently with the
              appropriate [IotUnityPlatformEntity] when
              [GetDataFromIotUnityPlatformUseCase] is listened on and there are
              no errors
            ''',
            build: () => iotUnityPlatformBloc,
            act: (iotUnityPlatformBloc) {
              when(
                mockGetDataFromIotUnityPlatformUseCase(
                  topicName: anyNamed(
                    'topicName',
                  ),
                ),
              ).thenAnswer(
                (_) => Stream.value(
                  const Right(
                    testIotUnityPlatformEntity,
                  ),
                ),
              );
              iotUnityPlatformBloc.add(
                const ListenDataFromIotUnityPlatformEvent(),
              );
            },
            verify: (iotUnityPlatformBloc) {
              verify(
                iotUnityPlatformBloc.getDataFromIotUnityPlatformUseCase(
                  topicName: testTopicName,
                ),
              ).called(
                1,
              );
            },
            expect: () => [
              const GettingDataFromIotUnityPlatformState(),
              const GotDataFromIotUnityPlatformState(
                testIotUnityPlatformEntity,
              ),
            ],
          );

          blocTest<IotUnityPlatformBloc, IotUnityPlatformState>(
            '''
              should emit [GettingDataFromIotUnityPlatformState] first, call
              [IotUnityPlatformBloc.getDataFromIotUnityPlatformUseCase] with
              the appropriate topic name and then
              [FailedToGetDataFromIotUnityPlatformState] subsequently with the
              appropriate message when [GetDataFromIotUnityPlatformUseCase] is
              listened on and there are errors and the failure is not
              MessageTopicMismatchFailure
            ''',
            build: () => iotUnityPlatformBloc,
            act: (iotUnityPlatformBloc) {
              when(
                mockGetDataFromIotUnityPlatformUseCase(
                  topicName: anyNamed(
                    'topicName',
                  ),
                ),
              ).thenAnswer(
                (_) => Stream.value(
                  const Left(
                    testFailure,
                  ),
                ),
              );
              iotUnityPlatformBloc.add(
                const ListenDataFromIotUnityPlatformEvent(),
              );
            },
            verify: (iotUnityPlatformBloc) {
              verify(
                iotUnityPlatformBloc.getDataFromIotUnityPlatformUseCase(
                  topicName: testTopicName,
                ),
              ).called(
                1,
              );
            },
            expect: () => [
              const GettingDataFromIotUnityPlatformState(),
              FailedToGetDataFromIotUnityPlatformState(
                testFailure.message,
              ),
            ],
          );
        },
      );

      group(
        'StopListeningDataFromIotUnityPlatformEvent',
        () {
          late StreamSubscription<Either<Failure, IotUnityPlatformEntity>>?
              mockGetDataFromIotUnityPlatformUseCaseStreamSubscription;

          setUp(
            () {
              mockGetDataFromIotUnityPlatformUseCaseStreamSubscription =
                  mockGetDataFromIotUnityPlatformUseCase(
                topicName: testTopicName,
              ).listen((event) {});
            },
          );

          tearDown(
            () {
              mockGetDataFromIotUnityPlatformUseCaseStreamSubscription
                  ?.cancel();
            },
          );

          blocTest<IotUnityPlatformBloc, IotUnityPlatformState>(
            '''
              Should cancel the subscription on the
              [GetDataFromIotUnityPlatformUseCase] stream when
              [StopListeningDataFromIotUnityPlatformEvent] is dispatched
            ''',
            setUp: () {},
            build: () => iotUnityPlatformBloc,
            act: (iotUnityPlatformBloc) {
              iotUnityPlatformBloc.add(
                const StopListeningDataFromIotUnityPlatformEvent(),
              );
            },
            verify: (_) {
              mockGetDataFromIotUnityPlatformUseCaseStreamSubscription
                  ?.cancel();
            },
          );
        },
      );
    },
  );
}
