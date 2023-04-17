// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/failure.dart';
import 'package:iot_interface_with_aws_iot_core/core/usecases/usecase.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/iot_unity_platform_entity.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/repositories/iot_unity_platform_repository.dart';

class GetDataFromIotUnityPlatformUseCase
    implements UseCase<IotUnityPlatformEntity> {
  GetDataFromIotUnityPlatformUseCase({
    required this.iotUnityPlatformRepository,
  });

  final IotUnityPlatformRepository iotUnityPlatformRepository;

  @override
  Stream<Either<Failure, IotUnityPlatformEntity>> call({
    required String topicName,
  }) =>
      iotUnityPlatformRepository.getDataFromIotUnityPlatform(
        topicName: topicName,
      );
}
