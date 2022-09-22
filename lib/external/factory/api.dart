import 'dart:convert';

import 'package:cfit/external/models/api.dart';
import 'package:http/http.dart' as http;

class ApiResponseFactory {
  ApiResponse fromHttpResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));

      return ApiResponse(
        data: data is List ? {'responses': data} : data,
        status: response.statusCode,
      );
    }
    throw errorHandler(response);
  }

  ApiException errorHandler(http.Response error) {
    if (error.statusCode >= 500) {
      return ServerException(error);
    }
    if (error.statusCode == 404) {
      return NotFoundException(error);
    }
    if (error.statusCode == 400) {
      return BadRequestException(error);
    }

    if (error.statusCode == 401) {
      return UnauthorizedException(error);
    }
    if (error.statusCode == 403) {
      return ForbiddenException(error);
    }
    
    if (error.statusCode == 422) {
      if (error.body.toLowerCase().contains('email_exists')) {
        return ForbiddenException(error);
      }
      if (error.body.toLowerCase().contains('invalid_id_token')) {
        return UnauthorizedException(error);
      }
      return NotFoundException(error);
    }
    return ApiException('Algo deu errado', error);
  }
}
