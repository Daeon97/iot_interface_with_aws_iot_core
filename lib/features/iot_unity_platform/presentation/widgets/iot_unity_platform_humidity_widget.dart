// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/core/utils/extensions.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';

class IotUnityPlatformHumidityWidget extends StatelessWidget {
  const IotUnityPlatformHumidityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(
              spacingDouble,
            ),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  smallSpacingDouble +
                      tinySpacingDouble +
                      tinySpacingDouble +
                      tinySpacingDouble,
                ),
              ),
            ),
            child: Row(
              children: [
                BlocBuilder<IotUnityPlatformBloc, IotUnityPlatformState>(
                  builder: (_, iotUnityPlatformState) => FaIcon(
                    FontAwesomeIcons.droplet,
                    size: spacingDouble +
                        tinySpacingDouble +
                        veryTinySpacingDouble,
                    color: _computeAppropriateTemperatureIconColor(
                      iotUnityPlatformState,
                    ),
                  ),
                ),
                const SizedBox(
                  width: spacingDouble,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      iotUnityPlatformHumidityLiteral,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    BlocBuilder<IotUnityPlatformBloc, IotUnityPlatformState>(
                      builder: (_, iotUnityPlatformState) => RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Text(
                                iotUnityPlatformState
                                        is GotDataFromIotUnityPlatformState
                                    ? '${iotUnityPlatformState.iotUnityPlatformEntity.humidity.makePresentable}'
                                    : '$nilDouble',
                                style: TextStyle(
                                  color: iotUnityPlatformState
                                          is GotDataFromIotUnityPlatformState
                                      ? Colors.black
                                      : Colors.black38,
                                  fontSize: largeSpacingDouble,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const TextSpan(
                              text: whiteSpace + whiteSpace,
                            ),
                            TextSpan(
                              text: humidityUnit,
                              style: TextStyle(
                                color: iotUnityPlatformState
                                        is GotDataFromIotUnityPlatformState
                                    ? Colors.black
                                    : Colors.black38,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

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
