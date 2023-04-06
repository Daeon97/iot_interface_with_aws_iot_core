// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:iot_interface_with_aws_iot_core/core/clients/mqtt_client.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/data_sources/iot_unity_platform_remote_data_source.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/repositories/iot_unity_platform_repository_implementation.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/usecases/get_data_from_iot_unity_platform_use_case.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/presentation/blocs/iot_unity_platform_bloc/iot_unity_platform_bloc.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final sl = GetIt.I;

void initDependencyInjection() {
  /* Feature -> IoT Unity Platform */
  sl

    // BLoC
    ..registerFactory(
      () => IotUnityPlatformBloc(
        sl(),
      ),
    )

    // Use cases
    ..registerLazySingleton(
      () => GetDataFromIotUnityPlatformUseCase(
        iotUnityPlatformRepository: sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton(
      () => IotUnityPlatformRepositoryImplementation(
        iotUnityPlatformRemoteDataSource: sl(),
      ),
    )

    // Data sources
    ..registerLazySingleton(
      () => IotUnityPlatformRemoteDataSourceImplementation(
        mqttClient: sl(),
      ),
    )

    // Core
    ..registerLazySingleton(
      () => MqttClient(
        securityContext: sl(),
        mqttServerClient: sl(),
      ),
    )

    // External
    ..registerLazySingleton(
      () => SecurityContext.defaultContext,
    )
    ..registerLazySingleton(
      () => MqttServerClient(
        sl.get(
          instanceName: mqttServer,
        ),
        sl.get(
          instanceName: mqttClientIdentifier,
        ),
      ),
    )

    // Primitives
    ..registerLazySingleton(
      () => awsIotCoreServerEndPointKey,
      instanceName: mqttServer,
    )
    ..registerLazySingleton(
      () => defaultClientId,
      instanceName: mqttClientIdentifier,
    );
}
