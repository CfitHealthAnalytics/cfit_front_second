import 'package:cfit/data/entity/credentials.dart';
import 'package:cfit/data/entity/login.dart';
import 'package:cfit/data/entity/register.dart';

abstract class AuthRepository {
  Future<LoginBodyResponse> login(LoginBodyRequest login);

  Future<RegisterBodyResponse> register(RegisterBodyRequest register);

  Future<Credentials> getStoredCredentials();

  Future<void> logout();
}
