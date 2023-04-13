// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class IotUnityPlatformSurroundingProgressBarWidget extends StatefulWidget {
  const IotUnityPlatformSurroundingProgressBarWidget({
    super.key,
  });

  @override
  State<IotUnityPlatformSurroundingProgressBarWidget> createState() =>
      _IotUnityPlatformSurroundingProgressBarWidgetState();
}

class _IotUnityPlatformSurroundingProgressBarWidgetState
    extends State<IotUnityPlatformSurroundingProgressBarWidget> {
  final _temperatureNotifier = ValueNotifier<double>(
    nilDouble,
  );

  @override
  void dispose() {
    _temperatureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(_) => BlocListener<IotUnityPlatformBloc, IotUnityPlatformState>(
        listener: (_, iotUnityPlatformState) {
          if (iotUnityPlatformState is GotDataFromIotUnityPlatformState) {
            _temperatureNotifier.value =
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
          valueNotifier: _temperatureNotifier,
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
