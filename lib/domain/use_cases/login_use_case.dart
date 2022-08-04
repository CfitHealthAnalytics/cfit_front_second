import 'package:cfit/data/entity/login.dart';
import 'package:cfit/data/models/auth.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(
    this._authRepository,
  );

  Future<void> call({
    required String email,
    required String password,
  }) async {
    await _authRepository.login(
      LoginBodyRequest(
        email: email,
        password: password,
      ),
    );
  }
}
