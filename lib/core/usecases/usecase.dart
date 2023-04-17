// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';

import 'package:iot_interface_with_aws_iot_core/core/errors/failure.dart';

abstract class UseCase<Entity> {
  const UseCase();

  Stream<Either<Failure, Entity>> call({
    required String topicName,
  });
}
