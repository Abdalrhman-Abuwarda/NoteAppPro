

class AppException implements Exception {
  final String? message;
  final String? perfix;
  final String? url;

  AppException([this.message, this.perfix, this.url]);
}


class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}


class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}


class ApiNotResponseException extends AppException {
  ApiNotResponseException([String? message, String? url])
      : super(message, 'Api not Responded', url);
}


class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'Bad Request', url);
}
