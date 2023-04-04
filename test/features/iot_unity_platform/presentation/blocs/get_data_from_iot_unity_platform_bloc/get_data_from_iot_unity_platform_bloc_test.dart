import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/usecases/usecases.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/blocs.dart';
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

  // test(
  //   '''
  //     should ensure that [GettingDataFromIotUnityPlatformState]
  //     is emitted as initial state
  //     ''',
  //   () {},
  // );
}
