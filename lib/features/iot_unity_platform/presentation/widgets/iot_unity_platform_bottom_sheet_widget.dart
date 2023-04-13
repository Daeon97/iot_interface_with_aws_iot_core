// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';

class IotUnityPlatformBottomSheetWidget extends StatelessWidget {
  const IotUnityPlatformBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<IotUnityPlatformBloc, IotUnityPlatformState>(
        builder: (_, iotUnityPlatformState) =>
            iotUnityPlatformState is GettingDataFromIotUnityPlatformState ||
                    iotUnityPlatformState
                        is FailedToGetDataFromIotUnityPlatformState
                ? BottomSheet(
                    enableDrag: false,
                    onClosing: () {},
                    builder: (_) => Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: spacingDouble,
                        horizontal: largeSpacingDouble,
                      ),
                      // height: largeSpacingDouble + spacingDouble,
                      decoration: BoxDecoration(
                        color: iotUnityPlatformState
                                is GettingDataFromIotUnityPlatformState
                            ? Colors.blue
                            : Colors.red,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(
                            largeSpacingDouble,
                          ),
                        ),
                      ),
                      child: Row(
                        children: iotUnityPlatformState
                                is FailedToGetDataFromIotUnityPlatformState
                            ? [
                                const FaIcon(
                                  FontAwesomeIcons.triangleExclamation,
                                  size: spacingDouble +
                                      tinySpacingDouble +
                                      veryTinySpacingDouble,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: spacingDouble,
                                ),
                                Expanded(
                                  child: Text(
                                    iotUnityPlatformState.message,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      // fontSize: largeSpacing,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ]
                            : const [
                                SizedBox(
                                  width: spacingDouble,
                                  height: spacingDouble,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                    strokeWidth: tinySpacingDouble,
                                  ),
                                ),
                                SizedBox(
                                  width: spacingDouble,
                                ),
                                Expanded(
                                  child: Text(
                                    iotUnityPlatformLoadingDataLiteral,
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontSize: largeSpacing,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
      );
}
