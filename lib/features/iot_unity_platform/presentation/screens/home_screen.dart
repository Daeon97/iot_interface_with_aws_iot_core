// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
        backgroundColor: Colors.black,
        body: BlocBuilder<IotUnityPlatformBloc, IotUnityPlatformState>(
          builder: (_, iotUnityPlatformState) {
            return Center(
              child: Text(
                iotUnityPlatformState is GotDataFromIotUnityPlatformState
                    ? '${iotUnityPlatformState.iotUnityPlatformEntity.humidity} ${iotUnityPlatformState.iotUnityPlatformEntity.temperature}'
                    : iotUnityPlatformState
                            is FailedToGetDataFromIotUnityPlatformState
                        ? '${iotUnityPlatformState.message}'
                        : '...',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      );
}
