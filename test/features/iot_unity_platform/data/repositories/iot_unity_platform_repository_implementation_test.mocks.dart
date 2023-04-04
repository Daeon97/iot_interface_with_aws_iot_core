// Mocks generated by Mockito 5.3.2 from annotations
// in iot_interface_with_aws_iot_core/test/features/iot_unity_platform/data/repositories/iot_unity_platform_repository_implementation_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/iot_unity_platform_remote_data_source.dart'
    as _i2;
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/models/models.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [IotUnityPlatformRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockIotUnityPlatformRemoteDataSource extends _i1.Mock
    implements _i2.IotUnityPlatformRemoteDataSource {
  @override
  _i3.Stream<_i4.IotUnityPlatformModel> getDataFromIotUnityPlatform(
          {required String? topicName}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDataFromIotUnityPlatform,
          [],
          {#topicName: topicName},
        ),
        returnValue: _i3.Stream<_i4.IotUnityPlatformModel>.empty(),
        returnValueForMissingStub:
            _i3.Stream<_i4.IotUnityPlatformModel>.empty(),
      ) as _i3.Stream<_i4.IotUnityPlatformModel>);
}