// ignore_for_file: public_member_api_docs

abstract class Failure {
  const Failure({
    required this.message,
  });

  final String message;
}

class BrokerFailure extends Failure {
  const BrokerFailure({
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
