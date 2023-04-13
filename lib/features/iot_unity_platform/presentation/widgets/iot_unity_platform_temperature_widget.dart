// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/core/utils/extensions.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/widgets/iot_unity_platform_appropriate_temperature_icon_widget.dart';

class IotUnityPlatformTemperatureWidget extends StatelessWidget {
  const IotUnityPlatformTemperatureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(
          veryLargeSpacingDouble,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade400,
              blurRadius: veryVeryLargeSpacingDouble,
              offset: const Offset(
                nilDouble,
                -spacingDouble - smallSpacingDouble,
              ),
            ),
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: veryVeryLargeSpacingDouble,
              offset: const Offset(
                nilDouble,
                spacingDouble + smallSpacingDouble,
              ),
            ),
          ],
        ),
        child: BlocBuilder<IotUnityPlatformBloc, IotUnityPlatformState>(
          builder: (_, iotUnityPlatformState) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IotUnityPlatformAppropriateTemperatureIconWidget(
                iotUnityPlatformState: iotUnityPlatformState,
              ),
              const SizedBox(
                width: spacingDouble,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.top,
                          child: Text(
                            iotUnityPlatformState
                                    is GotDataFromIotUnityPlatformState
                                ? '${iotUnityPlatformState.iotUnityPlatformEntity.temperature.makePresentable}'
                                : '$nilDouble',
                            style: TextStyle(
                              color: iotUnityPlatformState
                                      is GotDataFromIotUnityPlatformState
                                  ? Colors.black
                                  : Colors.black38,
                              fontSize: largeSpacingDouble + spacingDouble,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: whiteSpace + whiteSpace,
                        ),
                        TextSpan(
                          text: degreeCelcius,
                          style: TextStyle(
                            color: iotUnityPlatformState
                                    is GotDataFromIotUnityPlatformState
                                ? Colors.black
                                : Colors.black38,
                            fontSize: spacingDouble,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: spacingDouble,
                  ),
                  const Text(
                    iotUnityPlatformTemperatureLiteral,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
