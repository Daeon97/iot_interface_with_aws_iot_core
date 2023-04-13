// ignore_for_file: public_member_api_docs

import 'package:iot_interface_with_aws_iot_core/core/resources/numbers.dart';

extension HandyUtilities on double {
  double get makePresentable => double.parse(
        toStringAsFixed(
          veryTinySpacingDouble.toInt(),
        ),
      );
}
