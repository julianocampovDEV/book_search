class Failure {
  int? statusCode;
  String message;
  Exception? exception;

  Failure({required this.message, this.statusCode, this.exception});
}
