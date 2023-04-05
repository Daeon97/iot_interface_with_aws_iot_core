// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iot_interface_with_aws_iot_core/core/resources/strings.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/domain/usecases/get_data_from_iot_unity_platform_use_case.dart';

part 'get_data_from_iot_unity_platform_event.dart';

part 'get_data_from_iot_unity_platform_state.dart';

class GetDataFromIotUnityPlatformBloc extends Bloc<
    GetDataFromIotUnityPlatformEvent, GetDataFromIotUnityPlatformState> {
  GetDataFromIotUnityPlatformBloc(
    this.getDataFromIotUnityPlatformUseCase,
  ) : super(
          const GettingDataFromIotUnityPlatformState(),
        ) {
    on<GetDataFromIotUnityPlatformEvent>(
      (event, emit) {
        // getDataFromIotUnityPlatformUseCase(
        //   topicName: dotenv.env[res.iotUnityPlatformTopicNameKey]!,
        // ).listen(
        //   (failureOrEntity) {},
        // );
      },
    );
  }

  final GetDataFromIotUnityPlatformUseCase getDataFromIotUnityPlatformUseCase;
}
