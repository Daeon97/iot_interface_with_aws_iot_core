// ignore_for_file: public_member_api_docs

abstract class CustomException implements Exception {
  const CustomException({
    this.code,
    this.message,
  });

  final String? code;
  final String? message;
}
