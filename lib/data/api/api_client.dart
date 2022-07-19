import 'dart:convert';
import 'dart:typed_data';
import 'package:cfit/domain/core/constants/storage.constants.dart';
import 'package:cfit/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  //final SharedPreferences sharedPreferences = SharedPreferences();
  final int timeoutInSeconds = 30;

  final _storage = Get.find<GetStorage>();

  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';

  String token = "";

  Map<String, String> _mainHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  ApiClient(this.appBaseUrl) {
    /*
    updateHeader(
      token,
      "",
      this.sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
    );
    */
  }

  void updateHeader(String? token, String? zoneID, String? languageCode) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      AppConstants.ZONE_ID: zoneID ?? '',
      AppConstants.LOCALIZATION_KEY:
          languageCode ?? AppConstants.languages[0].languageCode
    };
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      var url = Uri.parse(appBaseUrl + uri);
      //var url = Uri.https(appBaseUrl, uri, queryParameters ?? {});
      //var url = Uri.https(appBaseUrl, uri, queryParameters ?? {});

      Http.Response _response = await Http.get(
        url,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);

      return response;
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, dynamic? headers) async {
    try {
      /*
        print('====> API Call: $uri\nToken: $token');
        print('====> API Body: $body');
        print(_mainHeaders);
      */
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);

      return response;
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: _body ?? response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        /* ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors[0].message);
            */
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = const Response(statusCode: 0, statusText: noInternetMessage);
    }
    return _response;
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {dynamic? headers}) async {
    try {
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        Uint8List _list = await multipart.file.readAsBytes();
        _request.files.add(Http.MultipartFile(
          multipart.key,
          multipart.file.readAsBytes().asStream(),
          _list.length,
          filename: '${DateTime.now().toString()}.png',
        ));
      }
      _request.fields.addAll(body);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      return handleResponse(_response);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body, {dynamic? headers}) async {
    try {
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {dynamic? headers}) async {
    try {
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  void setToken() {
    String token = getUserToken();
    updateHeader(token, '', '');
  }

  String getUserToken() {
    try {
      return (_storage.read(StorageConstants.tokenAuthorization) != null)
          ? _storage.read(StorageConstants.tokenAuthorization)
          : '';
    } catch (e) {
      return '';
    }
    //return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
