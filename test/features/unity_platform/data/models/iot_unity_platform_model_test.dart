import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/features/iot_unity_platform/data/models/models.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late IotUnityPlatformModel iotUnityPlatformModel;

  setUp(
    () {
      const testHumidity = 1.0;
      const testTemperature = 1.0;
      iotUnityPlatformModel = const IotUnityPlatformModel(
        humidity: testHumidity,
        temperature: testTemperature,
      );
    },
  );

  group(
    'from Json',
    () {
      test(
        '''
          should return the corresponding [IotUnityPlatformModel] object
          when the JSON response contains fields that are integers
        ''',
        () {
          final rawJson = jsonDecode(
            fixture(
              'iot_unity_platform_data_integers.json',
            ),
          ) as Map<String, dynamic>;

          final result = IotUnityPlatformModel.fromJson(
            rawJson,
          );

          expect(
            result,
            iotUnityPlatformModel,
          );
        },
      );

      test(
        '''
          should return the corresponding [IotUnityPlatformModel] object
          when the JSON response contains fields that are doubles
        ''',
        () {
          final rawJson = jsonDecode(
            fixture(
              'iot_unity_platform_data_doubles.json',
            ),
          ) as Map<String, dynamic>;

          final result = IotUnityPlatformModel.fromJson(
            rawJson,
          );

          expect(
            result,
            iotUnityPlatformModel,
          );
        },
      );
    },
  );

  group(
    'to Json',
    () {
      test(
        '''
          should return the JSON representation corresponding to the
          [IotUnityPlatformModel] object when [IotUnityPlatformModel.toJson]
          is called
        ''',
        () {
          final result = iotUnityPlatformModel.toJson();

          final expectedJson = {
            'humidity': 1.0,
            'temperature': 1.0,
          };
          expect(
            result,
            expectedJson,
          );
        },
      );
    },
  );
}
