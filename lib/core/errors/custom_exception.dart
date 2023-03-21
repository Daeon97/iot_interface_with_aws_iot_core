// ignore_for_file: public_member_api_docs

abstract class CustomException implements Exception {
  const CustomException({
    required this.message,
  });

  final String message;
}

class BrokerException extends CustomException {
  const BrokerException({
    required super.message,
  });
}
