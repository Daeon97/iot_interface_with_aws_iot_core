// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/failure.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/iot_unity_platform_entity.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/usecases/get_data_from_iot_unity_platform_use_case.dart';

part 'iot_unity_platform_event.dart';

part 'iot_unity_platform_state.dart';

class IotUnityPlatformBloc
    extends Bloc<IotUnityPlatformEvent, IotUnityPlatformState> {
  IotUnityPlatformBloc(
    this.getDataFromIotUnityPlatformUseCase,
  ) : super(
          const IotUnityPlatformInitialState(),
        ) {
    StreamSubscription<Either<Failure, IotUnityPlatformEntity>>?
        getDataFromIotUnityPlatformUseCaseStreamSubscription;

    on<ListenDataFromIotUnityPlatformEvent>(
      (event, emit) {
        emit(
          const GettingDataFromIotUnityPlatformState(),
        );
        getDataFromIotUnityPlatformUseCaseStreamSubscription =
            getDataFromIotUnityPlatformUseCase(
          topicName: dotenv.env[iotUnityPlatformTopicNameKey]!,
        ).listen(
          (failureOrIotUnityPlatformEntity) {
            failureOrIotUnityPlatformEntity.fold(
              (failure) {
                if (failure is! MessageTopicMismatchFailure) {
                  add(
                    FailedToGetDataFromIotUnityPlatformEvent(
                      failure.message,
                    ),
                  );
                }
              },
              (iotUnityPlatformEntity) {
                add(
                  GotDataFromIotUnityPlatformEvent(
                    iotUnityPlatformEntity,
                  ),
                );
              },
            );
          },
        );
      },
    );

    on<GotDataFromIotUnityPlatformEvent>(
      (event, emit) {
        emit(
          GotDataFromIotUnityPlatformState(
            event.iotUnityPlatformEntity,
          ),
        );
      },
    );

    on<FailedToGetDataFromIotUnityPlatformEvent>(
      (event, emit) {
        emit(
          FailedToGetDataFromIotUnityPlatformState(
            event.message,
          ),
        );
      },
    );

    on<StopListeningDataFromIotUnityPlatformEvent>(
      (event, emit) {
        getDataFromIotUnityPlatformUseCaseStreamSubscription?.cancel();
      },
    );
  }

  final GetDataFromIotUnityPlatformUseCase getDataFromIotUnityPlatformUseCase;
}
