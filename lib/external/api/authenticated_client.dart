import 'dart:convert';
import 'dart:io';

import 'package:cfit/domain/erros/rules.dart';
import 'package:cfit/external/factory/api.dart';
import 'package:cfit/external/models/api.dart';
import 'package:cfit/external/models/storage.dart';
import 'package:http/http.dart' as http;

import '../../util/app_constants.dart';

class AuthenticatedClient implements ApiClient {
  AuthenticatedClient({
    required this.baseUri,
    required this.storage,
    required this.factory,
  });
  final ApiResponseFactory factory;
  final Storage storage;
  final String baseUri;

  Future<ApiResponse> _get(
      {required String path, required String token}) async {
    final response = await http.get(
      Uri(
        host: baseUri,
        path: path,
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );
    return factory.fromHttpResponse(response);
  }

  Future<ApiResponse> _post({
    required String path,
    required String token,
    Map<String, dynamic>? body,
    File? file,
  }) async {
    late final http.Response response;
    if (body != null) {
      response = await http.post(
        Uri(
          host: baseUri,
          path: path,
          scheme: 'https',
        ),
        body: jsonEncode(body),
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );
    } else {
      final request = http.MultipartRequest(
        'POST',
        Uri(
          host: baseUri,
          path: path,
        ),
      )
        ..headers.addAll({
          'Authorization': 'Bearer $token',
          AppConstants.ZONE_ID: '',
          AppConstants.LOCALIZATION_KEY: 'pt-br'
        })
        ..files.add(http.MultipartFile.fromBytes(
          'image',
          file!.readAsBytesSync(),
        ));

      response = await http.Response.fromStream(await request.send());
    }
    return factory.fromHttpResponse(response);
  }

  Future<void> refreshToken() async {
    final refreshToken = await storage.get(AppConstants.TOKEN_REFRESH);
    final response = await http.post(
      Uri(
        host: baseUri,
        path: AppConstants.REFRESH_TOKEN,
        scheme: 'https',
      ),
      body: jsonEncode({'refresh_token': refreshToken}),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );
    final apiResponse = factory.fromHttpResponse(response);

    await storage.setAll({
      AppConstants.TOKEN: apiResponse.data['id_token'],
      AppConstants.TOKEN_REFRESH: apiResponse.data['refresh_token'],
    });
  }

  @override
  Future<ApiResponse> get({
    required String path,
  }) async {
    final token = await storage.get<String>(AppConstants.TOKEN);
    if (token == null) {
      throw NotLoggedUser();
    }
    try {
      return await _get(path: path, token: token);
    } on UnauthorizedException {
      await refreshToken();
      return await _get(path: path, token: token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> post({
    required String path,
    Map<String, dynamic>? body,
    File? file,
  }) async {
    final token = await storage.get<String>(AppConstants.TOKEN);
    if (token == null) {
      throw NotLoggedUser();
    }
    try {
      return await _post(
        path: path,
        token: token,
        body: body,
        file: file,
      );
    } on UnauthorizedException catch (_) {
      await refreshToken();
      return await _post(
        path: path,
        token: token,
        body: body,
        file: file,
      );
    } catch (_) {
      rethrow;
    }
  }
}
