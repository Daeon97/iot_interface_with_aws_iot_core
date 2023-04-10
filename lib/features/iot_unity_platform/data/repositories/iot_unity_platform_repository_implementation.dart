// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/custom_exception.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/failure.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/iot_unity_platform_remote_data_source.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/models/iot_unity_platform_model.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/iot_unity_platform_entity.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/repositories/iot_unity_platform_repository.dart';

class IotUnityPlatformRepositoryImplementation
    implements IotUnityPlatformRepository {
  const IotUnityPlatformRepositoryImplementation({
    required this.iotUnityPlatformRemoteDataSource,
  });

  final IotUnityPlatformRemoteDataSource iotUnityPlatformRemoteDataSource;

  @override
  Stream<Either<Failure, IotUnityPlatformEntity>> getDataFromIotUnityPlatform({
    required String topicName,
  }) {
    late StreamController<Either<Failure, IotUnityPlatformEntity>>
        streamController;
    late StreamSubscription<IotUnityPlatformModel>
        remoteDataSourceStreamSubscription;

    streamController =
        StreamController<Either<Failure, IotUnityPlatformEntity>>(
      onListen: () {
        remoteDataSourceStreamSubscription = iotUnityPlatformRemoteDataSource
            .getDataFromIotUnityPlatform(
          topicName: topicName,
        )
            .listen(
          (iotUnityPlatformModel) {
            streamController.sink.add(
              Right(
                iotUnityPlatformModel,
              ),
            );
          },
          onError: (dynamic error) {
            streamController.sink.add(
              Left(
                _computeFailure(error),
              ),
            );
          },
        );
      },
      onCancel: () async {
        await remoteDataSourceStreamSubscription.cancel();
        await streamController.sink.close();
        await streamController.close();
      },
    );
    return streamController.stream;
  }

  Failure _computeFailure(dynamic error) {
    late final Failure failure;

    if (error is CustomException) {
      switch (CustomException) {
        case NoMessagesFromBrokerException:
          failure = const NoMessagesFromBrokerFailure(
            message: noMessagesFromBrokerFailureMessage,
          );
          break;
        case BadCertificateException:
          failure = const BadCertificateFailure(
            message: badCertificateFailureMessage,
          );
          break;
        case TopicSubscriptionException:
          failure = const TopicSubscriptionFailure(
            message: topicSubscriptionFailureMessage,
          );
          break;
        case UnsolicitedDisconnectionException:
          failure = const UnsolicitedDisconnectionFailure(
            message: unsolicitedDisconnectionFailureMessage,
          );
          break;
        case CouldNotConnectToBrokerException:
          failure = const CouldNotConnectToBrokerFailure(
            message: couldNotConnectToBrokerFailureMessage,
          );
          break;
        case MessageTopicMismatchException:
          failure = const MessageTopicMismatchFailure(
            message: messageTopicMismatchFailureMessage,
          );
          break;
        case BadMessageFormatException:
          failure = const BadMessageFormatFailure(
            message: badMessageFormatFailureMessage,
          );
          break;
        default:
          failure = const UnknownFailure(
            message: unknownFailureMessage,
          );
          break;
      }
    } else {
      failure = const UnknownFailure(
        message: unknownFailureMessage,
      );
    }

    return failure;
  }

  @visibleForTesting
  Failure computeFailure(dynamic error) => _computeFailure(
        error,
      );
}
