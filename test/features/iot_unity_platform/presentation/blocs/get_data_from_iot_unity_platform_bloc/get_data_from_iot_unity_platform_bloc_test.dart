import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/usecases/get_data_from_iot_unity_platform_use_case.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/get_data_from_iot_unity_platform_bloc/get_data_from_iot_unity_platform_bloc.dart';
import 'package:mockito/annotations.dart';

import 'get_data_from_iot_unity_platform_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetDataFromIotUnityPlatformUseCase>(),
])
void main() {
  late MockGetDataFromIotUnityPlatformUseCase
      mockGetDataFromIotUnityPlatformUseCase;
  late GetDataFromIotUnityPlatformBloc getDataFromIotUnityPlatformBloc;

  setUp(
    () {
      mockGetDataFromIotUnityPlatformUseCase =
          MockGetDataFromIotUnityPlatformUseCase();
      getDataFromIotUnityPlatformBloc = GetDataFromIotUnityPlatformBloc(
        mockGetDataFromIotUnityPlatformUseCase,
      );
    },
  );

  tearDown(() {
    getDataFromIotUnityPlatformBloc.close();
  });

  test(
    '''
      should ensure that [GettingDataFromIotUnityPlatformState]
      is emitted as initial state
      ''',
    () {
      expect(
        getDataFromIotUnityPlatformBloc.state,
        const GettingDataFromIotUnityPlatformState(),
      );
    },
  );
}
