import 'package:cfit/data/api/api_client.dart';
import 'package:cfit/domain/core/abstractions/http_connect.interface.dart';
import 'package:cfit/domain/core/exceptions/default.exception.dart';
import 'package:cfit/domain/core/exceptions/user_not_found.exception.dart';
import 'package:cfit/infrastructure/translate/login.translate.dart';
import 'package:cfit/util/app_constants.dart';

import 'dto/authenticate_user.body.dart';
import 'dto/authenticate_user.response.dart';

class AuthService {
  final IHttpConnect _connect;
  final ApiClient apiClient;
  const AuthService(this.apiClient, IHttpConnect connect) : _connect = connect;
  //const AuthService(this.apiClient, IHttpConnect connect) : _connect = connect;

  String get _prefix => 'auth';

  Future<dynamic> login(String email, String password) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URI, {"email": email, "password": password}, '');
  }

  Future<dynamic> register(String email, String nome, String password,
      String dataNascimento, String genero) async {
    return await apiClient.postData(
        AppConstants.REGISTER_URI,
        {
          "email": email,
          "nome": nome,
          "data_nascimento": dataNascimento,
          "genero": genero,
          "password": password
        },
        '');
  }

  Future<AuthenticateUserResponse> authenticateUser(
    AuthenticateUserBody body,
  ) async {
    final response = await _connect.post(
      '$_prefix/' + AppConstants.AUTHENTICATION,
      body.toJson(),
      decoder: (value) => AuthenticateUserResponse.fromJson(
        value as Map<String, dynamic>,
      ),
    );

    if (response.success) {
      return response.payload!;
    } else {
      switch (response.statusCode) {
        case 404:
          throw UserNotFoundException(
            message: LoginTranslate.userPasswordWrongSnackbar,
          );
        default:
          throw DefaultException(message: response.payload!.error!);
      }
    }
  }
}
