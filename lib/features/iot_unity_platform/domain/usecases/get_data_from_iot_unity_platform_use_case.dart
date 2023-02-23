// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/failure.dart';
import 'package:iot_interface_with_aws_iot_core/core/usecases/usecases.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/entities.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/repositories/repositories.dart';

class GetDataFromIotUnityPlatformUseCase
    implements UseCase<IotUnityPlatformEntity, Params> {
  GetDataFromIotUnityPlatformUseCase({
    required this.iotUnityPlatformRepository,
  });

  IotUnityPlatformRepository iotUnityPlatformRepository;

  @override
  Future<Either<Failure, IotUnityPlatformEntity>> call(Params params) =>
      iotUnityPlatformRepository.getDataFromIotUnityPlatform();
}

class Params extends Equatable {
  const Params();

  @override
  List<Object?> get props => [];
}
