import 'dart:convert';

import 'package:cfit/external/models/api.dart';
import 'package:http/http.dart' as http;

class ApiResponseFactory {
  ApiResponse fromHttpResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ApiResponse(
        data: jsonDecode(response.body),
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
    if (error.statusCode == 422) {
      return NotFoundException(error);
    }
    return ApiException('Algo deu errado', error);
  }
}
