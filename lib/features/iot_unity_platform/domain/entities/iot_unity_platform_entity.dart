// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

class IotUnityPlatformEntity extends Equatable {
  const IotUnityPlatformEntity({
    required this.humidity,
    required this.temperature,
  });

  final double humidity;
  final double temperature;

  @override
  List<Object?> get props => [
        humidity,
        temperature,
      ];
}
