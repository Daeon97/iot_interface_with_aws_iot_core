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
