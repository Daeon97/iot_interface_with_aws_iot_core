// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/widgets/iot_unity_platform_bottom_sheet_widget.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/widgets/iot_unity_platform_humidity_widget.dart';
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
  @override
  void initState() {
    BlocProvider.of<IotUnityPlatformBloc>(context).add(
      const ListenDataFromIotUnityPlatformEvent(),
    );
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<IotUnityPlatformBloc>(context).add(
      const StopListeningDataFromIotUnityPlatformEvent(),
    );
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
        bottomSheet: const IotUnityPlatformBottomSheetWidget(),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(
              spacingDouble,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const IotUnityPlatformHumidityWidget(),
                const SizedBox(
                  height: veryLargeSpacingDouble,
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: const [
                    IotUnityPlatformTemperatureWidget(),
                    IotUnityPlatformSurroundingProgressBarWidget(),
                    Align(
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
                    Align(
                      alignment: Alignment(
                        nilDotNineDouble + nilDotNilEight,
                        veryTinySpacingDouble,
                      ),
                      child: Text(
                        '$oneEightyDouble$degree',
                        style: TextStyle(
                          color: Colors.black,
                          // fontSize: largeSpacing,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
