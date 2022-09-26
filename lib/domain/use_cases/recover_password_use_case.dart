import 'package:cfit/data/models/auth.dart';

class RecoverPasswordUseCase {
  final AuthRepository _authRepository;

  RecoverPasswordUseCase(
    this._authRepository,
  );

  Future<void> call({
    required String email,
  }) async {
    await _authRepository.recoverPassword(email);
  }
}
