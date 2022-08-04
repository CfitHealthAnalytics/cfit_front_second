import 'dart:convert';
import 'dart:io';

import 'package:cfit/external/factory/api.dart';
import 'package:cfit/external/models/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constants.dart';

class AuthenticatedClient implements ApiClient {
  AuthenticatedClient({
    required this.baseUri,
    required this.storage,
    required this.factory,
  });
  final ApiResponseFactory factory;
  final SharedPreferences storage;
  final String baseUri;

  String get token => storage.getString(AppConstants.TOKEN)!;

  @override
  Future<ApiResponse> get({
    required String path,
  }) async {
    final response = await http.get(
      Uri(
        host: baseUri,
        path: path,
      ),
      headers: {
        'Authorization': 'Bearer $token',
        AppConstants.ZONE_ID: '',
        AppConstants.LOCALIZATION_KEY: 'pt-br'
      },
    );
    return factory.fromHttpResponse(response);
  }

  @override
  Future<ApiResponse> post({
    required String path,
    Map<String, dynamic>? body,
    File? file,
  }) async {
    assert(
        (body == null && file == null) || (body != null && file != null),
        'Apenas um dos dois atributos podem ser envidados '
        'mas os dois não podem ser nulos');
    late final http.Response response;
    if (body != null) {
      response = await http.post(
        Uri(
          host: baseUri,
          path: path,
          scheme: jsonEncode(body),
        ),
        headers: {
          'Authorization': 'Bearer $token',
          AppConstants.ZONE_ID: '',
          AppConstants.LOCALIZATION_KEY: 'pt-br'
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
}
