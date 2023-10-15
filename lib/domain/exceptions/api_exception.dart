sealed class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  factory ApiException.fromStatusCode(int? code) {
    return switch (code) {
      400 => BadRequest(),
      401 => Unauthorized(),
      500 => InternalServerError(),
      _ => Unknown(code),
    };
  }
}

final class BadRequest implements ApiException {
  @override
  String get message => "Bad Request";
}

final class Unauthorized implements ApiException {
  @override
  String get message => "Unauthorized";
}

final class InternalServerError implements ApiException {
  @override
  String get message => "Internal Server Error";
}

final class NoInternetConnection implements ApiException {
  @override
  String get message => "No Internet Connection";
}

final class Unknown implements ApiException {
  const Unknown(this.statusCode);

  final int? statusCode;

  @override
  String get message => "Unknown Error; StatusCode: $statusCode";
}
