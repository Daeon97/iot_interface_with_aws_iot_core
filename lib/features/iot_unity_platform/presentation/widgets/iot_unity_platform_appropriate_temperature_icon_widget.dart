// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';

class IotUnityPlatformAppropriateTemperatureIconWidget extends StatelessWidget {
  const IotUnityPlatformAppropriateTemperatureIconWidget({
    required this.iotUnityPlatformState,
    super.key,
  });

  final IotUnityPlatformState iotUnityPlatformState;

  @override
  Widget build(BuildContext context) => FaIcon(
        _computeAppropriateTemperatureIcon(
          iotUnityPlatformState,
        ),
        size: largeSpacingDouble + smallSpacingDouble,
        color: _computeAppropriateTemperatureIconColor(
          iotUnityPlatformState,
        ),
      );

  IconData _computeAppropriateTemperatureIcon(
    IotUnityPlatformState iotUnityPlatformState,
  ) {
    late IconData iconData;
    if (iotUnityPlatformState is GotDataFromIotUnityPlatformState) {
      final temperature =
          iotUnityPlatformState.iotUnityPlatformEntity.temperature;

      if (temperature >= nilDouble && temperature < twentyEightDouble) {
        iconData = FontAwesomeIcons.temperatureLow;
      } else if (temperature >= twentyEightDouble &&
          temperature < fiftySixDouble) {
        iconData = FontAwesomeIcons.temperatureQuarter;
      } else if (temperature >= fiftySixDouble &&
          temperature < eightyFourDouble) {
        iconData = FontAwesomeIcons.temperatureHalf;
      } else if (temperature >= eightyFourDouble &&
          temperature < hundredTwelveDouble) {
        iconData = FontAwesomeIcons.temperatureThreeQuarters;
      } else {
        iconData = FontAwesomeIcons.temperatureHigh;
      }
    } else {
      iconData = FontAwesomeIcons.temperatureEmpty;
    }

    return iconData;
  }

  Color _computeAppropriateTemperatureIconColor(
    IotUnityPlatformState iotUnityPlatformState,
  ) {
    late Color color;
    if (iotUnityPlatformState is GotDataFromIotUnityPlatformState) {
      final temperature =
          iotUnityPlatformState.iotUnityPlatformEntity.temperature;

      if (temperature >= nilDouble && temperature < twentyEightDouble) {
        color = Colors.lightBlueAccent;
      } else if (temperature >= twentyEightDouble &&
          temperature < fiftySixDouble) {
        color = Colors.blue;
      } else if (temperature >= fiftySixDouble &&
          temperature < eightyFourDouble) {
        color = Colors.blueGrey;
      } else if (temperature >= eightyFourDouble &&
          temperature < hundredTwelveDouble) {
        color = Colors.orangeAccent;
      } else {
        color = Colors.red;
      }
    } else {
      color = Colors.black38;
    }

    return color;
  }
}
