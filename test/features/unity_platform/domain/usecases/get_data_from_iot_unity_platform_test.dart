// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/usecases/usecases.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/entities.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/repositories/repositories.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/usecases/usecases.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<IotUnityPlatformRepository>(),
])
import 'get_data_from_iot_unity_platform_test.mocks.dart';

void main() {
  late MockIotUnityPlatformRepository mockIotUnityPlatformRepository;
  late GetDataFromIotUnityPlatformUseCase
      getDataFromIotUnityPlatformUseCase;

  setUp(() {
    mockIotUnityPlatformRepository = MockIotUnityPlatformRepository();
    getDataFromIotUnityPlatformUseCase =
        GetDataFromIotUnityPlatformUseCase(
          iotUnityPlatformRepository: mockIotUnityPlatformRepository,
        );
  });

  const testHumidity = 1.0;
  const testTemperature = 1.0;
  const iotUnityPlatformEntity = IotUnityPlatformEntity(
    humidity: testHumidity,
    temperature: testTemperature,
  );

  test(
    'should ensure that GetDataFromIotUnityPlatformUseCase implements the UseCase interface',
    () {
      expect(getDataFromIotUnityPlatformUseCase, isA<UseCase<IotUnityPlatformEntity, Params>>());
    },
  );

  test('should get data from the IoT Unity Platform from the repository',
      () async {
    when(mockIotUnityPlatformRepository.getDataFromIotUnityPlatform())
        .thenAnswer((_) async => const Right(iotUnityPlatformEntity));

    final result = await getDataFromIotUnityPlatformUseCase(const Params());

    verify(mockIotUnityPlatformRepository.getDataFromIotUnityPlatform());
    verifyNoMoreInteractions(mockIotUnityPlatformRepository);
    expect(result, const Right(iotUnityPlatformEntity));
  });
}
