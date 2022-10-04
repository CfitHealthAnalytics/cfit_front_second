import 'package:cfit/data/entity/credentials.dart';
import 'package:cfit/data/entity/login.dart';
import 'package:cfit/data/entity/register.dart';
import 'package:cfit/data/models/auth.dart';
import 'package:cfit/external/models/api.dart';
import 'package:cfit/external/models/storage.dart';
import 'package:cfit/util/app_constants.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient client;
  final Storage storage;

  AuthRepositoryImpl({
    required this.client,
    required this.storage,
  });

  @override
  Future<LoginBodyResponse> login(LoginBodyRequest data) async {
    final response = await client.post(
      path: AppConstants.LOGIN_URI,
      body: data.toMap(),
    );
    final loginResponse = LoginBodyResponse.fromMap(response.data);

    await storage.setAll({
      AppConstants.TOKEN: loginResponse.idToken,
      AppConstants.TOKEN_EXPIRESIN: loginResponse.expiresIn,
      AppConstants.TOKEN_REFRESH: loginResponse.refreshToken,
      AppConstants.USER_ID: loginResponse.localId,
    });

    return loginResponse;
  }

  @override
  Future<RegisterBodyResponse> register(RegisterBodyRequest data) async {
    final response = await client.post(
      path: AppConstants.REGISTER_URI,
      body: data.toMap(),
    );
    final registerResponse = RegisterBodyResponse.fromMap(response.data);
    await storage.setAll({
      AppConstants.TOKEN: registerResponse.idToken,
      AppConstants.TOKEN_EXPIRESIN: registerResponse.expiresIn,
      AppConstants.TOKEN_REFRESH: registerResponse.refreshToken,
      AppConstants.USER_ID: registerResponse.localId,
    });

    return registerResponse;
  }

  @override
  Future<Credentials> getStoredCredentials() async {
    final responses = await storage.getAll({
      AppConstants.TOKEN_REFRESH,
      AppConstants.USER_ID,
      AppConstants.TOKEN,
      AppConstants.TOKEN_EXPIRESIN,
    });

    return Credentials(
      refreshToken: responses[AppConstants.TOKEN_REFRESH],
      localId: responses[AppConstants.USER_ID],
      idToken: responses[AppConstants.TOKEN],
      expiresIn: responses[AppConstants.TOKEN_EXPIRESIN],
    );
  }

  @override
  Future<void> logout() async {
    await storage.deleteAll({
      AppConstants.TOKEN,
      AppConstants.TOKEN_EXPIRESIN,
      AppConstants.TOKEN_REFRESH,
      AppConstants.USER_ID,
      AppConstants.IS_CONECTA_USER,
    });
  }

  @override
  Future<void> recoverPassword(String email) async {
    await client.post(
      path: AppConstants.RECOVER_PASSWORD,
      body: {
        'email': email,
      },
    );
  }

  @override
  Future<void> setConnectaToken(String token) async {
    await storage.set(AppConstants.TOKEN, data: token);
  }

  @override
  Future<bool> verifyAlreadyExistsUser(String cpf, String email) async {
    try {
      await client.post(
        path: AppConstants.VERIFY_ALREADY_EXIST,
        body: {
          'hash': cpf,
          'email': email,
        },
      );
      return true;
    } on NotFoundException {
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> completeAccount(CompleteAccountRequest register) async {
    await client.post(
      path: AppConstants.REGISTER_CONECTA_USER,
      body: register.toMap(),
    );
  }
}
