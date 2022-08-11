import 'dart:io';

import 'package:http/http.dart' as Http;

abstract class ApiClient {
  Future<ApiResponse> get({
    required String path,
    int retries = 3,
  });

  Future<ApiResponse> post({
    required String path,
    Map<String, dynamic> body,
    File file,
    int retries = 3,
  });
}

class ApiResponse {
  final Map<String, dynamic> data;
  final int status;

  ApiResponse({
    required this.data,
    required this.status,
  });
}

class ApiException implements Exception {
  const ApiException(this.message, this.error);
  final String message;
  final Http.Response error;
}

class NotFoundException extends ApiException {
  const NotFoundException(Http.Response error)
      : super(
          'recurso não encontrado',
          error,
        );
}

class BadRequestException extends ApiException {
  const BadRequestException(Http.Response error)
      : super(
          'Erro nos dados enviados',
          error,
        );
}


class UnauthorizedException extends ApiException {
  const UnauthorizedException(Http.Response error)
      : super(
          'Token expirado',
          error,
        );
}

class ForbiddenException extends ApiException {
  const ForbiddenException(Http.Response error)
      : super(
          'Não tem permissão para realizar essa operação',
          error,
        );
}

class ServerException extends ApiException {
  const ServerException(Http.Response error)
      : super(
          'Houve um problema com o servidor',
          error,
        );
}
