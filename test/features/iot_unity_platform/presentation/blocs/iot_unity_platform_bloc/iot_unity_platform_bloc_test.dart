import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/iot_unity_platform_entity.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/usecases/get_data_from_iot_unity_platform_use_case.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';
import 'package:mockito/annotations.dart';

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
      testLoadEnv('.env');
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
    'GetDataFromIotUnityPlatformBloc',
    () {
      const testGotDataFromIotUnityPlatformState =
          GotDataFromIotUnityPlatformState(
        IotUnityPlatformEntity(
          humidity: 1.0,
          temperature: 1.0,
        ),
      );

      test(
        '''
          should ensure that [GetDataFromIotUnityPlatformInitialState]
          is emitted as initial state
        ''',
        () {
          expect(
            iotUnityPlatformBloc.state,
            const IotUnityPlatformInitialState(),
          );
        },
      );

      blocTest<IotUnityPlatformBloc, IotUnityPlatformState>(
        '''
          should emit [GotDataFromIotUnityPlatformState] with the appropriate
          entity when everything goes successfully 
        ''',
        build: () => iotUnityPlatformBloc,
        seed: () => testGotDataFromIotUnityPlatformState,
        act: (iotUnityPlatformBloc) =>
            iotUnityPlatformBloc.add(
          const ListenDataFromIotUnityPlatformEvent(),
        ),
        expect: () => [
          const GettingDataFromIotUnityPlatformState(),
          testGotDataFromIotUnityPlatformState,
        ],
      );
    },
  );
}
