import 'package:cfit/data/entity/register.dart';
import 'package:cfit/data/models/auth.dart';
import 'package:cfit/data/models/user.dart';

class CompleteAccountUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  CompleteAccountUseCase(
    this._authRepository,
    this._userRepository,
  );

  Future<void> call({
    required String email,
    required String cpf,
    required String name,
    required String dateBirth,
    required String gender,
    required String deficiency,
  }) async {
    await _authRepository.completeAccount(CompleteAccountRequest(
      email: email,
      cpf: cpf,
      name: name,
      dateBirth: dateBirth,
      gender: gender,
      deficiency: deficiency,
      password: '',
    ));

    final userCFIT = await _userRepository.getUserByEmail(email);

    await _userRepository.setUserInStorage(userCFIT);
    await _userRepository.setConectaUser(true);
  }
}
