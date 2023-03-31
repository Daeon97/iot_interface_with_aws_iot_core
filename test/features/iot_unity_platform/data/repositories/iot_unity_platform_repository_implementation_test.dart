import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/repositories/iot_unity_platform_repository_implementation.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// import 'iot_unity_platform_repository_implementation_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<>(),])
void main() {
  late IotUnityPlatformRepositoryImplementation
      iotUnityPlatformRepositoryImplementation;

  const testServer = 'test server';
  const testClientId = 'test client ID';
  const testPort = 1883;
  const testMaximumConnectionAttempts = 5;

  setUp(
    () {
      // iotUnityPlatformRepositoryImplementation =
      //     IotUnityPlatformRepositoryImplementation();
    },
  );
}
