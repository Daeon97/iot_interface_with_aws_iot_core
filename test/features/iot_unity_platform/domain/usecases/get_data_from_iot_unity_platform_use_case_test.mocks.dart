// Mocks generated by Mockito 5.3.2 from annotations
// in iot_interface_with_aws_iot_core/test/features/iot_unity_platform/domain/usecases/get_data_from_iot_unity_platform_use_case_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:iot_interface_with_aws_iot_core/core/errors/failure.dart'
    as _i5;
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/iot_unity_platform_entity.dart'
    as _i6;
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/repositories/iot_unity_platform_repository.dart'
    as _i2;
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

/// A class which mocks [IotUnityPlatformRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIotUnityPlatformRepository extends _i1.Mock
    implements _i2.IotUnityPlatformRepository {
  @override
  _i3.Stream<_i4.Either<_i5.Failure, _i6.IotUnityPlatformEntity>>
      getDataFromIotUnityPlatform({required String? topicName}) =>
          (super.noSuchMethod(
            Invocation.method(
              #getDataFromIotUnityPlatform,
              [],
              {#topicName: topicName},
            ),
            returnValue: _i3.Stream<
                _i4.Either<_i5.Failure, _i6.IotUnityPlatformEntity>>.empty(),
            returnValueForMissingStub: _i3.Stream<
                _i4.Either<_i5.Failure, _i6.IotUnityPlatformEntity>>.empty(),
          ) as _i3.Stream<_i4.Either<_i5.Failure, _i6.IotUnityPlatformEntity>>);
}
