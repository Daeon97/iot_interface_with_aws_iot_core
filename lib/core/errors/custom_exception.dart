// ignore_for_file: public_member_api_docs

abstract class CustomException implements Exception {
  const CustomException({
    final String? code,
    final String? message,
  });
}
