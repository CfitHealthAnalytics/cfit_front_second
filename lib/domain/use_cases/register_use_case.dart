import 'package:cfit/data/entity/register.dart';
import 'package:cfit/data/models/auth.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(
    this._authRepository,
  );

  Future<void> call({
    required String email,
    required String password,
    required String dateBirth,
    required String genre,
    required String name,
  }) async {
    await _authRepository.register(
      RegisterBodyRequest(
        email: email,
        password: password,
        dateBirth: dateBirth,
        genre: genre,
        name: name,
      ),
    );
  }
}
