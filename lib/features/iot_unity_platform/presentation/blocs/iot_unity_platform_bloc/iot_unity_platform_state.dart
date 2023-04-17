// ignore_for_file: public_member_api_docs

part of 'iot_unity_platform_bloc.dart';

abstract class IotUnityPlatformState extends Equatable {
  const IotUnityPlatformState();

  @override
  List<Object> get props => [];
}

class IotUnityPlatformInitialState
    extends IotUnityPlatformState {
  const IotUnityPlatformInitialState();

  @override
  List<Object> get props => [];
}

class GettingDataFromIotUnityPlatformState
    extends IotUnityPlatformState {
  const GettingDataFromIotUnityPlatformState();

  @override
  List<Object> get props => [];
}

class GotDataFromIotUnityPlatformState
    extends IotUnityPlatformState {
  const GotDataFromIotUnityPlatformState(
    this.iotUnityPlatformEntity,
  );

  final IotUnityPlatformEntity iotUnityPlatformEntity;

  @override
  List<Object> get props => [
        iotUnityPlatformEntity,
      ];
}

class FailedToGetDataFromIotUnityPlatformState
    extends IotUnityPlatformState {
  const FailedToGetDataFromIotUnityPlatformState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}
