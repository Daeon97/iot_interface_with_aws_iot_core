// ignore_for_file: public_member_api_docs

abstract class Failure {
  const Failure({
    required this.message,
  });

  final String message;
}

class NoMessagesFromBrokerFailure extends Failure {
  const NoMessagesFromBrokerFailure({
    required super.message,
  });
}

class BadCertificateFailure extends Failure {
  const BadCertificateFailure({
    required super.message,
  });
}

class TopicSubscriptionFailure extends Failure {
  const TopicSubscriptionFailure({
    required super.message,
  });
}

class UnsolicitedDisconnectionFailure extends Failure {
  const UnsolicitedDisconnectionFailure({
    required super.message,
  });
}

class CouldNotConnectToBrokerFailure extends Failure {
  const CouldNotConnectToBrokerFailure({
    required super.message,
  });
}

class MessageTopicMismatchFailure extends Failure {
  const MessageTopicMismatchFailure({
    required super.message,
  });
}

class BadMessageFormatFailure extends Failure {
  const BadMessageFormatFailure({
    required super.message,
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
  });
}
