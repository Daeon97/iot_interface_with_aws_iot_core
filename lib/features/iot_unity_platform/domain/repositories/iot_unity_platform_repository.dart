// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/errors.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/entities.dart';

abstract class IotUnityPlatformRepository {
  const IotUnityPlatformRepository();

  Stream<Either<Failure, IotUnityPlatformEntity>> getDataFromIotUnityPlatform({
    required String topicName,
  });
}
