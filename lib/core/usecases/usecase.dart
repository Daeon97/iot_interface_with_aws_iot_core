// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:iot_interface_with_aws_iot_core/core/errors/errors.dart';

abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Either<Failure, Type>> call(
    Params params,
  );
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
