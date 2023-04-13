// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';

class IotUnityPlatformStatusWidget extends StatelessWidget {
  const IotUnityPlatformStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<IotUnityPlatformBloc, IotUnityPlatformState>(
        builder: (_, iotUnityPlatformState) => Container(
          padding: const EdgeInsets.all(
            spacingDouble,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: _computeAppropriateStatusColor(
                iotUnityPlatformState,
              ),
            ),
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
              FaIcon(
                _computeAppropriateStatusIcon(
                  iotUnityPlatformState,
                ),
                size: spacingDouble + tinySpacingDouble + veryTinySpacingDouble,
                color: _computeAppropriateStatusColor(
                  iotUnityPlatformState,
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
                    iotUnityPlatformStatusLiteral,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: tinySpacingDouble + veryTinySpacingDouble,
                  ),
                  Text(
                    _computeAppropriateStatusText(
                      iotUnityPlatformState,
                    ),
                    style: TextStyle(
                      color: _computeAppropriateStatusColor(
                        iotUnityPlatformState,
                      ),
                      fontSize: largeSpacingDouble - smallSpacingDouble,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  IconData _computeAppropriateStatusIcon(
    IotUnityPlatformState iotUnityPlatformState,
  ) {
    late IconData iconData;

    if (iotUnityPlatformState is GotDataFromIotUnityPlatformState) {
      iconData = FontAwesomeIcons.circleDot;
    } else if (iotUnityPlatformState
        is FailedToGetDataFromIotUnityPlatformState) {
      iconData = FontAwesomeIcons.triangleExclamation;
    } else {
      iconData = FontAwesomeIcons.circle;
    }
    return iconData;
  }

  Color _computeAppropriateStatusColor(
    IotUnityPlatformState iotUnityPlatformState,
  ) {
    late Color color;

    if (iotUnityPlatformState is GettingDataFromIotUnityPlatformState) {
      color = Colors.black38;
    } else if (iotUnityPlatformState is GotDataFromIotUnityPlatformState) {
      color = Colors.green;
    } else if (iotUnityPlatformState
        is FailedToGetDataFromIotUnityPlatformState) {
      color = Colors.red;
    } else {
      color = Colors.black12;
    }

    return color;
  }

  String _computeAppropriateStatusText(
    IotUnityPlatformState iotUnityPlatformState,
  ) {
    late String text;

    if (iotUnityPlatformState is GettingDataFromIotUnityPlatformState) {
      text = iotUnityPlatformLoadingLiteral;
    } else if (iotUnityPlatformState is GotDataFromIotUnityPlatformState) {
      text = iotUnityPlatformOnlineLiteral;
    } else if (iotUnityPlatformState
        is FailedToGetDataFromIotUnityPlatformState) {
      text = iotUnityPlatformErrorLiteral;
    } else {
      text = iotUnityPlatformOfflineLiteral;
    }

    return text;
  }
}
