// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:iot_interface_with_aws_iot_core/core/errors/errors.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/resources.dart'
    as res;
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/data_sources.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/models/models.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/entities/entities.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/repositories/repositories.dart';

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
            late final Failure failure;

            if (error is CustomException) {
              switch (CustomException) {
                case NoMessagesFromBrokerException:
                  failure = const NoMessagesFromBrokerFailure(
                    message: res.noMessagesFromBrokerFailureMessage,
                  );
                  break;
                case BadCertificateException:
                  failure = const BadCertificateFailure(
                    message: res.badCertificateFailureMessage,
                  );
                  break;
                case TopicSubscriptionException:
                  failure = const TopicSubscriptionFailure(
                    message: res.topicSubscriptionFailureMessage,
                  );
                  break;
                case UnsolicitedDisconnectionException:
                  failure = const UnsolicitedDisconnectionFailure(
                    message: res.unsolicitedDisconnectionFailureMessage,
                  );
                  break;
                case CouldNotConnectToBrokerException:
                  failure = const CouldNotConnectToBrokerFailure(
                    message: res.couldNotConnectToBrokerFailureMessage,
                  );
                  break;
                case MessageTopicMismatchException:
                  failure = const MessageTopicMismatchFailure(
                    message: res.messageTopicMismatchFailureMessage,
                  );
                  break;
                default:
                  failure = const UnknownFailure(
                    message: res.unknownFailureMessage,
                  );
                  break;
              }
            } else {
              failure = const UnknownFailure(
                message: res.unknownFailureMessage,
              );
            }

            streamController.sink.add(
              Left(
                failure,
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
}
