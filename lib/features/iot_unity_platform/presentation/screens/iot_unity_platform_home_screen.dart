// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/widgets/iot_unity_platform_surrounding_progress_bar_widget.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/widgets/iot_unity_platform_temperature_widget.dart';

class IotUnityPlatformHomeScreen extends StatefulWidget {
  const IotUnityPlatformHomeScreen({
    super.key,
  });

  @override
  State<IotUnityPlatformHomeScreen> createState() =>
      IotUnityPlatformHomeScreenState();
}

class IotUnityPlatformHomeScreenState
    extends State<IotUnityPlatformHomeScreen> {
  final _temperatureNotifier = ValueNotifier<double>(
    nilDouble,
  );

  @override
  void dispose() {
    _temperatureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            iotUnityPlatformNameLiteral,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(
                largeSpacingDouble,
              ),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(
              spacingDouble,
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                const IotUnityPlatformTemperatureWidget(),
                IotUnityPlatformSurroundingProgressBarWidget(
                  temperatureNotifier: _temperatureNotifier,
                ),
                const Align(
                  alignment: Alignment(
                    -nilDotNineDouble,
                    veryTinySpacingDouble,
                  ),
                  child: Text(
                    '$nilDouble$degree',
                    style: TextStyle(
                      color: Colors.black,
                      // fontSize: largeSpacing,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment(
                    nilDotNineDouble,
                    veryTinySpacingDouble,
                  ),
                  child: Text(
                    '$largeSpacingDouble$degree',
                    style: TextStyle(
                      color: Colors.black,
                      // fontSize: largeSpacing,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
