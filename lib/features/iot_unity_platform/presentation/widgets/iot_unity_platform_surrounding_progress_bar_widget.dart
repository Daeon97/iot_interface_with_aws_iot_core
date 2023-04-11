// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class IotUnityPlatformSurroundingProgressBarWidget extends StatefulWidget {
  const IotUnityPlatformSurroundingProgressBarWidget({
    required this.temperatureNotifier,
    super.key,
  });

  final ValueNotifier<double> temperatureNotifier;

  @override
  State<IotUnityPlatformSurroundingProgressBarWidget> createState() =>
      _IotUnityPlatformSurroundingProgressBarWidgetState();
}

class _IotUnityPlatformSurroundingProgressBarWidgetState
    extends State<IotUnityPlatformSurroundingProgressBarWidget> {
  @override
  void dispose() {
    widget.temperatureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<IotUnityPlatformBloc, IotUnityPlatformState>(
        listener: (_, iotUnityPlatformState) {
          if (iotUnityPlatformState is GotDataFromIotUnityPlatformState) {
            widget.temperatureNotifier.value =
                iotUnityPlatformState.iotUnityPlatformEntity.temperature;
          }
        },
        child: SimpleCircularProgressBar(
          size: veryVeryLargeSpacingDouble + veryVeryLargeSpacingDouble,
          maxValue: threeSixtyDouble,
          progressStrokeWidth:
              smallSpacingDouble - tinySpacingDouble - tinySpacingDouble,
          backStrokeWidth:
              smallSpacingDouble - tinySpacingDouble - tinySpacingDouble,
          backColor: Colors.transparent,
          startAngle: veryVeryLargeSpacingDouble +
              veryVeryLargeSpacingDouble +
              (spacingDouble - tinySpacingDouble),
          valueNotifier: widget.temperatureNotifier,
          progressColors: const [
            Colors.lightBlueAccent,
            Colors.greenAccent,
            Colors.blueAccent,
            Colors.blueGrey,
            Colors.grey,
            Colors.brown,
            Colors.orangeAccent,
            Colors.deepOrangeAccent,
          ],
        ),
      );
}
