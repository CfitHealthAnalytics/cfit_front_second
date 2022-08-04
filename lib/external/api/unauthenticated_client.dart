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
  }) async {
    final response = await http.get(Uri(
      host: baseUri,
      path: path,
    ));
    return factory.fromHttpResponse(response);
  }

  @override
  Future<ApiResponse> post({
    required String path,
    Map<String, dynamic>? body,
    File? file,
  }) async {
    assert(
        (body != null && file == null) || (body != null && file == null),
        'Apenas um dos dois atributos podem ser envidados '
        'mas os dois não podem ser nulos');
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
}
