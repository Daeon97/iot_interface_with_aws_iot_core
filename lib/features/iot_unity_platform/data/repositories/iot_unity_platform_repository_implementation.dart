// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/failure.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/iot_unity_platform_entity.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/repositories/repositories.dart';

class IotUnityPlatformRepositoryImplementation
    implements IotUnityPlatformRepository {
  const IotUnityPlatformRepositoryImplementation();

  @override
  Stream<Either<Failure, IotUnityPlatformEntity>> getDataFromIotUnityPlatform({
    required String topicName,
  }) {
    // TODO: implement getDataFromIotUnityPlatform
    throw UnimplementedError();
  }
}
