import 'package:flutter_test/flutter_test.dart';
import 'package:iot_interface_with_aws_iot_core/core/utils/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(
    () {
      inputConverter = const InputConverter();
    },
  );

  const testDouble = 20.78;
  const testDoubleString = '20.78';
  const testInt = 51;
  const testIntString = '51';
  const testString = '7345';
  const testStringString = '7345';
  const testBool = true;
  const testBoolString = 'true';

  test(
    '''
      should return the appropriate string representation when
      [InputConverter.valueToString] is called on a double
    ''',
    () {
      final result = inputConverter.valueToString<double>(
        testDouble,
      );
      expect(
        result,
        testDoubleString,
      );
    },
  );

  test(
    '''
      should return the appropriate string representation when
      [InputConverter.valueToString] is called on an integer
    ''',
    () {
      final result = inputConverter.valueToString<int>(
        testInt,
      );
      expect(
        result,
        testIntString,
      );
    },
  );

  test(
    '''
      should return the appropriate string representation when
      [InputConverter.valueToString] is called on a string
    ''',
    () {
      final result = inputConverter.valueToString<String>(
        testString,
      );
      expect(
        result,
        testStringString,
      );
    },
  );

  test(
    '''
      should return the appropriate string representation when
      [InputConverter.valueToString] is called on an boolean
    ''',
    () {
      final result = inputConverter.valueToString<bool>(
        testBool,
      );
      expect(
        result,
        testBoolString,
      );
    },
  );
}
