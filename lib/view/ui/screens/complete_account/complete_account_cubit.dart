import 'package:bloc/bloc.dart';
import 'package:cfit/domain/models/user.dart';
import 'package:cfit/domain/use_cases/complete_account_use_case.dart';

import 'complete_account_navigation.dart';
import 'complete_account_state.dart';

class CompleteAccountCubit extends Cubit<CompleteAccountState> {
  CompleteAccountCubit({
    required this.conectaUser,
    required this.initialTab,
    required this.navigation,
    required this.completeAccountUseCase,
  }) : super(CompleteAccountState.empty());

  final ConectaUser conectaUser;
  final int initialTab;
  final CompleteAccountUseCase completeAccountUseCase;

  final CompleteAccountNavigation navigation;

  void onBack() {
    navigation.goBack();
  }

  void onChangeDateBirth(String dateBirth) {
    emit(state.copyWith(dateBirth: dateBirth));
  }

  void onChangeGender(String? gender) {
    if (gender == null) return;
    emit(state.copyWith(gender: gender.toGender()));
  }

  Future<void> completeAccount() async {
    await completeAccountUseCase(
      cpf: conectaUser.preferredUsername,
      email: conectaUser.email,
      name: conectaUser.name,
      dateBirth: state.dateBirth,
      gender: state.gender.toStringRepresentation(),
      deficiency: 'false',
    );

    navigation.toHome(initialTab: initialTab);
  }
}
