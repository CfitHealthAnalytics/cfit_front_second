import 'package:cfit/data/entity/credentials.dart';
import 'package:cfit/data/entity/login.dart';
import 'package:cfit/data/entity/register.dart';

abstract class AuthRepository {
  Future<LoginBodyResponse> login(LoginBodyRequest login);

  Future<RegisterBodyResponse> register(RegisterBodyRequest register);
  
  Future<void> completeAccount(CompleteAccountRequest register);

  Future<Credentials> getStoredCredentials();

  Future<void> logout();
  
  Future<void> recoverPassword(String email);
  
  Future<void> setConnectaToken(String token);

  Future<bool> verifyAlreadyExistsUser(String cpf, String email);
}
