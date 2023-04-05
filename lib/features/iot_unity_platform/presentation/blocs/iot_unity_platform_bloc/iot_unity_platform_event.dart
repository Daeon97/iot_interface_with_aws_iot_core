// ignore_for_file: public_member_api_docs

part of 'iot_unity_platform_bloc.dart';

abstract class IotUnityPlatformEvent extends Equatable {
  const IotUnityPlatformEvent();

  @override
  List<Object> get props => [];
}

class ListenDataFromIotUnityPlatformEvent extends IotUnityPlatformEvent {
  const ListenDataFromIotUnityPlatformEvent();

  @override
  List<Object> get props => [];
}

class GotDataFromIotUnityPlatformEvent extends IotUnityPlatformEvent {
  const GotDataFromIotUnityPlatformEvent(
    this.iotUnityPlatformEntity,
  );

  final IotUnityPlatformEntity iotUnityPlatformEntity;

  @override
  List<Object> get props => [
        iotUnityPlatformEntity,
      ];
}

class FailedToGetDataFromIotUnityPlatformEvent extends IotUnityPlatformEvent {
  const FailedToGetDataFromIotUnityPlatformEvent(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}

class StopListeningDataFromIotUnityPlatformEvent extends IotUnityPlatformEvent {
  const StopListeningDataFromIotUnityPlatformEvent();

  @override
  List<Object> get props => [];
}
