// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/screens/home_screen.dart';
import 'package:iot_interface_with_aws_iot_core/injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: _blocProviders,
        child: const MaterialApp(
          onGenerateRoute: _routes,
        ),
      );

  List<BlocProvider> get _blocProviders => [
        BlocProvider<IotUnityPlatformBloc>(
          create: sl(),
        ),
      ];
}

Route<String> _routes(RouteSettings settings) => MaterialPageRoute(
      builder: (_) {
        switch (settings.name) {
          case homeScreenRoute:
          default:
            return const HomeScreen();
        }
      },
    );
