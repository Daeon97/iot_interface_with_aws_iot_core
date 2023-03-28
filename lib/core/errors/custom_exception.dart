// ignore_for_file: public_member_api_docs

abstract class CustomException implements Exception {
  const CustomException({
    required this.message,
  });

  final String message;
}

class NoMessagesFromBrokerException extends CustomException {
  const NoMessagesFromBrokerException({
    required super.message,
  });
}

class BadCertificateException extends CustomException {
  const BadCertificateException({
    required super.message,
  });
}

class TopicSubscriptionException extends CustomException {
  const TopicSubscriptionException({
    required super.message,
  });
}

class UnsolicitedDisconnectionException extends CustomException {
  const UnsolicitedDisconnectionException({
    required super.message,
  });
}
