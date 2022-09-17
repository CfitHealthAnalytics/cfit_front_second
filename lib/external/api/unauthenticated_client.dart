import 'dart:convert';
import 'dart:io';

import 'package:cfit/external/factory/api.dart';
import 'package:cfit/external/models/api.dart';
import 'package:http/http.dart' as http;

class UnauthenticatedClient implements ApiClient {
  UnauthenticatedClient({
    required this.baseUri,
    required this.factory,
  });

  final ApiResponseFactory factory;
  final String baseUri;

  @override
  Future<ApiResponse> get({
    required String path,
    int retries = 0,
    Map<String, dynamic>? query,
  }) async {
    final response = await http.get(
      Uri(
        host: baseUri,
        path: path,
        queryParameters: query,
      ),
    );
    return factory.fromHttpResponse(response);
  }

  @override
  Future<ApiResponse> post({
    required String path,
    Map<String, dynamic>? body,
    File? file,
    int retries = 3,
    Map<String, dynamic>? query,
    bool? isBodyEmpty,
  }) async {
    late final http.Response response;
    if (body != null) {
      response = await http.post(
        Uri(host: baseUri, path: path, scheme: 'https', queryParameters: query),
        body: jsonEncode(body),
        headers: {
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
          ))
        ..files.add(http.MultipartFile.fromBytes(
          'image',
          file!.readAsBytesSync(),
        ));
      response = await http.Response.fromStream(await request.send());
    }
    return factory.fromHttpResponse(response);
  }

  @override
  Future<ApiResponse> delete({
    required String path,
    int retries = 3,
    Map<String, dynamic>? query,
  }) {
    throw UnimplementedError();
  }
}
