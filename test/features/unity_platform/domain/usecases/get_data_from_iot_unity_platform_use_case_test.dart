// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/errors.dart';
import 'package:iot_interface_with_aws_iot_core/core/usecases/usecases.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/entities.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/repositories/repositories.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/usecases/usecases.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_data_from_iot_unity_platform_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IotUnityPlatformRepository>(),
])

void main() {
  late MockIotUnityPlatformRepository mockIotUnityPlatformRepository;
  late GetDataFromIotUnityPlatformUseCase getDataFromIotUnityPlatformUseCase;

  setUp(
    () {
      mockIotUnityPlatformRepository = MockIotUnityPlatformRepository();
      getDataFromIotUnityPlatformUseCase = GetDataFromIotUnityPlatformUseCase(
        iotUnityPlatformRepository: mockIotUnityPlatformRepository,
      );
    },
  );

  const testHumidity = 1.0;
  const testTemperature = 1.0;
  const testIotUnityPlatformEntity = IotUnityPlatformEntity(
    humidity: testHumidity,
    temperature: testTemperature,
  );

  const testTopicName = 'topic/name';

  test(
    'should ensure that [GetDataFromIotUnityPlatformUseCase] implements the [UseCase] interface with [IotUnityPlatformEntity] as generic',
    () {
      expect(
        getDataFromIotUnityPlatformUseCase,
        isA<UseCase<IotUnityPlatformEntity>>(),
      );
    },
  );

  test(
    'should return a [Future] containing [IotUnityPlatformEntity] when GetDataFromIotUnityPlatformUseCase.call() is called',
    () async {
      final expectedAnswer = Future.value(
        const Right<Failure, IotUnityPlatformEntity>(
          testIotUnityPlatformEntity,
        ),
      );
      when(
        mockIotUnityPlatformRepository.getDataFromIotUnityPlatform(
          topicName: anyNamed('topicName'),
        ),
      ).thenAnswer(
        (_) => expectedAnswer,
      );

      final result = getDataFromIotUnityPlatformUseCase(
        topicName: testTopicName,
      );

      verify(
        mockIotUnityPlatformRepository.getDataFromIotUnityPlatform(
          topicName: testTopicName,
        ),
      ).called(1);
      verifyNoMoreInteractions(
        mockIotUnityPlatformRepository,
      );
      expect(
        result,
        equals(
          expectedAnswer,
        ),
      );
    },
  );
}
